import 'package:freezed_annotation/freezed_annotation.dart';

import '../dataset/message_entity.dart';

part 'chat_entity.freezed.dart';
part 'chat_entity.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity(
      {required String id,
      required List<MessageEntity> messages}) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);
}
