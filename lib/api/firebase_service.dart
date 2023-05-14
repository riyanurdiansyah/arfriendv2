import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:arfriendv2/entities/error_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseApiService {
  Future<Either<ErrorEntity, bool>> login(String email, String password);

  Future<Either<ErrorEntity, List<DatasetEntity>>> getDataset();

  Future<Either<ErrorEntity, bool>> deleteDataset(String id);

  Future<Either<ErrorEntity, bool>> saveDataset(Map<String, dynamic> body);

  Future<Either<ErrorEntity, bool>> createChat(Map<String, dynamic> body);

  Future<Either<ErrorEntity, bool>> updateChat(Map<String, dynamic> body);

  Stream<ChatEntity> streamHistoryChat(String id);
}
