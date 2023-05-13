import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/entities/error_entity.dart';
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
}
