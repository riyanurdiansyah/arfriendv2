import 'package:freezed_annotation/freezed_annotation.dart';

import '../dataset/message_entity.dart';

part 'chat_entity.freezed.dart';
part 'chat_entity.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity(
      {required String idUser,
      required String idChat,
      @Default("") String idTarget,
      @Default("") String target,
      @Default("") String title,
      @Default([]) List<MessageEntity> messages}) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);
}
