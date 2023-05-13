import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/error_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Stream<ChatEntity> streamHistoryChat(String id) {
    final stream =
        FirebaseFirestore.instance.collection("chat").doc(id).snapshots();
    return stream.map((e) => ChatEntity.fromJson(e.data()!));
  }
}