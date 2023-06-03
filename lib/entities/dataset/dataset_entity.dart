import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_entity.dart';

part 'dataset_entity.freezed.dart';
part 'dataset_entity.g.dart';

@freezed
class DatasetEntity with _$DatasetEntity {
  const factory DatasetEntity({
    required String addedBy,
    required String createdAt,
    required String id,
    required MessageEntity messages,
    required int number,
    required String title,
    required String to,
    required String type,
    required String updatedAt,
    @Default(0) int token,
    @Default(1) int page,
  }) = _DatasetEntity;

  factory DatasetEntity.fromJson(Map<String, dynamic> json) =>
      _$DatasetEntityFromJson(json);
}
