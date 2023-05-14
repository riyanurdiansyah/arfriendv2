import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:arfriendv2/entities/dataset/message_entity.dart';
import 'package:arfriendv2/entities/error_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_constanta.dart';

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
      List<MessageEntity> messages) async {
    Dio dio = Dio();
    List<Map<String, dynamic>> messagesJson = [];
    for (var data in messages) {
      messagesJson.add({"role": data.role, "content": data.content});
    }
    final data = {"model": "gpt-3.5-turbo", "messages": messagesJson};
    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };
    debugPrint("CEK BODY : $data");
    debugPrint("CEK HEADER : $headers");

    try {
      final response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("CEK RESPONSE : ${response.data}");
      int code = response.statusCode ?? 500;
      if (code == 200) {
        return Right(
          MessageEntity.fromJson(response.data["choices"][0]["message"])
              .copyWith(
            id: const Uuid().v4(),
            date: DateTime.now().toIso8601String(),
          ),
        );
      }

      return Left(ErrorEntity(
          code: 400, message: "Terjadi kesalahan silahkan coba lagi"));
    } catch (e) {
      return Left(ErrorEntity(code: 500, message: e.toString()));
    }
  }
}
