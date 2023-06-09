import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String role,
    required String content,
    @Default(false) bool hidden,
    @Default("") String id,
    @Default(false) bool isRead,
    @Default(false) bool isError,
    @Default("") String date,
    @Default(0) int token,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);
}
