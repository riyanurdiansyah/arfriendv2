import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/error_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseApiService {
  Future<Either<ErrorEntity, bool>> login(String email, String password);

  Stream<ChatEntity> streamHistoryChat(String id);
}
