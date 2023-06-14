import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/entities/category/category_entity.dart';
import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:arfriendv2/entities/dataset/message_entity.dart';
import 'package:arfriendv2/entities/divisi/divisi_entity.dart';
import 'package:arfriendv2/entities/error_entity.dart';
import 'package:arfriendv2/entities/role/role_entity.dart';
import 'package:arfriendv2/entities/user/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';

class FirebaseApiServiceImpl implements FirebaseApiService {
  @override
  Future<Either<ErrorEntity, bool>> login(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (response.user != null) {
        return const Right(true);
      }
      return Left(ErrorEntity(code: 404, message: "User is not found"));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, String>> regist(Map<String, dynamic> body) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: body["email"],
        password: "arfriend",
      )
          .then((value) {
        if (value.user != null) {
          return Right(value.user!.uid);
        }
        return const Right("");
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'weak-password') {
        errorMessage = "Password terlalu lemah";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Email sudah terdaftar";
      } else {
        errorMessage = "Terjadi kesalahan silahkan coba lagi...";
      }
      return Left(ErrorEntity(code: 400, message: errorMessage));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Stream<ChatEntity> streamChat(String id) {
    final stream = FirebaseFirestore.instance
        .collection("chat")
        .where("idChat", isEqualTo: id)
        .snapshots();
    return stream.map((e) => ChatEntity.fromJson(e.docs[0].data()));
  }

  @override
  Future<Either<ErrorEntity, List<DatasetEntity>>> getDataset() async {
    List<DatasetEntity> dataset = [];
    try {
      final response =
          await FirebaseFirestore.instance.collection("dataset").get();

      for (var data in response.docs) {
        dataset.add(DatasetEntity.fromJson(data.data()));
      }
      return Right(dataset);
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> deleteDataset(String id) async {
    try {
      return await FirebaseFirestore.instance
          .collection("dataset")
          .doc(id)
          .delete()
          .then((value) => const Right(true));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> saveDataset(
      Map<String, dynamic> body) async {
    try {
      final count =
          (await FirebaseFirestore.instance.collection("dataset").get())
              .docs
              .length;
      body["number"] = count + 1;
      return FirebaseFirestore.instance
          .collection("dataset")
          .doc(body["id"])
          .set(body)
          .then((_) {
        return const Right(true);
      });
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> updateChat(
      Map<String, dynamic> body) async {
    try {
      return await FirebaseFirestore.instance
          .collection("chat")
          .doc(body["idChat"])
          .update(body)
          .onError((error, stackTrace) => Left("ERROR : ${error.toString()}"))
          .then((value) => const Right(true));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> createChat(
      Map<String, dynamic> body) async {
    try {
      return await FirebaseFirestore.instance
          .collection("chat")
          .doc(body["idChat"])
          .set(body)
          .then((value) => const Right(true));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Stream<List<ChatEntity>> streamHistoryChat(String id) {
    List<ChatEntity> listChat = [];
    final stream = FirebaseFirestore.instance
        .collection("chat")
        .where("idUser", isEqualTo: id)
        .snapshots();
    return stream.map((e) {
      listChat.clear();
      for (var data in e.docs) {
        listChat.add(ChatEntity.fromJson(data.data()));
      }
      return listChat;
    });
  }

  @override
  Future<Either<ErrorEntity, List<ChatEntity>>> getHistoryChat(
      String id) async {
    try {
      List<ChatEntity> listChat = [];
      final response = await FirebaseFirestore.instance
          .collection("chat")
          .where("idUser", isEqualTo: id)
          .get();
      for (var data in response.docs) {
        listChat.add(ChatEntity.fromJson(data.data()));
      }
      return Right(listChat);
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> deleteHistoryById(String id) async {
    try {
      return FirebaseFirestore.instance
          .collection("chat")
          .doc(id)
          .delete()
          .then((_) => const Right(true));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, MessageEntity>> sendMessageToChatGPT(
    Map<String, dynamic> headers,
    List<MessageEntity> messages, {
    double? temperature,
  }) async {
    Dio dio = Dio();
    List<Map<String, dynamic>> messagesJson = [];
    for (var data in messages) {
      messagesJson.add({"role": data.role, "content": data.content});
    }
    final data = {
      "model": "gpt-3.5-turbo",
      "temperature": temperature ?? 0.4,
      "messages": messagesJson,
    };

    try {
      final response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      int code = response.statusCode ?? 500;
      if (code == 200) {
        // final stringInput = response.data["choices"][0]["message"].toString();
        // if (stringInput.contains("https")) {
        //   List<String> links = stringInput.split('https://');
        //   if (stringInput.startsWith('https://')) {
        //     links.removeAt(0);
        //   }
        //   launchUrlString("https://${links[1]}");
        //   // js.context.callMethod('open', [links[1]]);
        // }
        return Right(
          MessageEntity.fromJson(response.data["choices"][0]["message"])
              .copyWith(
            id: const Uuid().v4(),
            date: DateTime.now().toIso8601String(),
            token: response.data["usage"]["completion_tokens"],
          ),
        );
      }

      return Left(ErrorEntity(
          code: 400, message: "Terjadi kesalahan silahkan coba lagi"));
    } catch (e) {
      debugPrint("CEK ERROR : ${e.toString()}");
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Stream<List<RoleEntity>> streamRoles() {
    List<RoleEntity> roles = [];
    final stream = FirebaseFirestore.instance.collection("roles").snapshots();
    return stream.map((e) {
      for (var data in e.docs) {
        roles.add(RoleEntity.fromJson(data.data()));
      }
      return roles;
    });
  }

  @override
  Stream<List<DivisiEntity>> streamDivisi() {
    List<DivisiEntity> divisions = [];
    final stream =
        FirebaseFirestore.instance.collection("divisions").snapshots();
    return stream.map((e) {
      for (var data in e.docs) {
        divisions.add(DivisiEntity.fromJson(data.data()));
      }
      return divisions;
    });
  }

  @override
  Stream<List<CategoryEntity>> streamCategory(String id) {
    List<CategoryEntity> divisions = [];
    final stream = FirebaseFirestore.instance
        .collection("category")
        .where("idDivisi", isEqualTo: id)
        .snapshots();
    return stream.map((e) {
      for (var data in e.docs) {
        divisions.add(CategoryEntity.fromJson(data.data()));
      }
      return divisions;
    });
  }

  @override
  Future<Either<ErrorEntity, bool>> streamCreateChat(
      Map<String, dynamic> body) async {
    try {
      return await FirebaseFirestore.instance
          .collection("streamChat")
          .doc()
          .set(body)
          .then((value) => const Right(true));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> streamUpdateChat(
      Map<String, dynamic> body) async {
    try {
      return await FirebaseFirestore.instance
          .collection("streamChat")
          .doc()
          .set(body)
          .then((value) => const Right(true));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, ChatEntity>> getChats(String idChat) async {
    try {
      final data =
          await FirebaseFirestore.instance.collection("chat").doc(idChat).get();
      if (data.exists) {
        return Right(ChatEntity.fromJson(data.data()!));
      } else {
        return Left(ErrorEntity(code: 404, message: "Data not found"));
      }
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, int>> checkTokenPrompt(
      Map<String, dynamic> headers, String prompt) async {
    Dio dio = Dio();
    final data = {
      "model": "gpt-3.5-turbo",
      "temperature": 0,
      "max_tokens": 1,
      "messages": [
        {
          "role": "user",
          "content": prompt,
        }
      ],
    };

    try {
      final response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      int code = response.statusCode ?? 500;
      if (code == 200) {
        final stringInput = response.data["choices"][0]["message"].toString();
        if (stringInput.contains("https")) {
          List<String> links = stringInput.split('https://');
          if (stringInput.startsWith('https://')) {
            links.removeAt(0);
          }
          launchUrlString("https://${links[1]}");
          // js.context.callMethod('open', [links[1]]);
        }
        print("RES CHECK TOKEN : ${response.data}");
        return Right(response.data["usage"]["prompt_tokens"] ?? 0);
      }

      return Left(ErrorEntity(
          code: 400,
          message: response.data["error"]["message"] ??
              "Terjadi kesalahan silahkan coba lagi"));
    } catch (e) {
      debugPrint("CEK ERROR : ${e.toString()}");
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, List<UserEntity>>> getUsers() async {
    List<UserEntity> dataset = [];
    try {
      final response =
          await FirebaseFirestore.instance.collection("users").get();

      for (var data in response.docs) {
        dataset.add(UserEntity.fromJson(data.data()));
      }
      return Right(dataset);
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> registUser(
      Map<String, dynamic> body) async {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(body["id"])
          .set(body)
          .then((_) {
        return const Right(true);
      });
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorEntity, UserEntity>> getUserById(String id) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      if (!response.exists) {
        return Left(ErrorEntity(code: 404, message: "User tidak ditemukan"));
      }
      return Right(UserEntity.fromJson(response.data()!));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }
}
