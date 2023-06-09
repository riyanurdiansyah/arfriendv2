import 'package:arfriendv2/entities/category/category_entity.dart';
import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:arfriendv2/entities/dataset/message_entity.dart';
import 'package:arfriendv2/entities/divisi/divisi_entity.dart';
import 'package:arfriendv2/entities/error_entity.dart';
import 'package:arfriendv2/entities/user/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/role/role_entity.dart';

abstract class FirebaseApiService {
  Future<Either<ErrorEntity, bool>> login(String email, String password);

  Future<Either<ErrorEntity, String>> regist(Map<String, dynamic> body);

  Future<Either<ErrorEntity, UserEntity>> getUserById(String id);

  Future<Either<ErrorEntity, List<UserEntity>>> getUsers();

  Future<Either<ErrorEntity, List<DatasetEntity>>> getDataset();

  Future<Either<ErrorEntity, bool>> deleteDataset(String id);

  Future<Either<ErrorEntity, bool>> saveDataset(Map<String, dynamic> body);

  Future<Either<ErrorEntity, bool>> createChat(Map<String, dynamic> body);

  Future<Either<ErrorEntity, bool>> updateChat(Map<String, dynamic> body);

  Future<Either<ErrorEntity, List<ChatEntity>>> getHistoryChat(String id);

  Future<Either<ErrorEntity, ChatEntity>> getChats(String id);

  Future<Either<ErrorEntity, bool>> deleteHistoryById(String id);

  Future<Either<ErrorEntity, MessageEntity>> sendMessageToChatGPT(
      Map<String, dynamic> headers,
      List<MessageEntity> messages,
      String model,
      int tokens,
      {double? temperature});

  Stream<ChatEntity> streamChat(String id);

  Stream<List<ChatEntity>> streamHistoryChat(String id);

  Stream<List<RoleEntity>> streamRoles();

  Stream<List<DivisiEntity>> streamDivisi();

  Stream<List<CategoryEntity>> streamCategory(String id);

  Future<Either<ErrorEntity, bool>> streamCreateChat(Map<String, dynamic> body);

  Future<Either<ErrorEntity, int>> checkTokenPrompt(
      Map<String, dynamic> headers, String prompt);

  Future<Either<ErrorEntity, bool>> registUser(Map<String, dynamic> body);
}
