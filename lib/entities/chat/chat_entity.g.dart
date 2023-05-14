// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatEntity _$$_ChatEntityFromJson(Map<String, dynamic> json) =>
    _$_ChatEntity(
      idUser: json['idUser'] as String,
      idChat: json['idChat'] as String,
      idTarget: json['idTarget'] as String? ?? "",
      target: json['target'] as String? ?? "",
      title: json['title'] as String? ?? "",
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => MessageEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ChatEntityToJson(_$_ChatEntity instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'idChat': instance.idChat,
      'idTarget': instance.idTarget,
      'target': instance.target,
      'title': instance.title,
      'messages': instance.messages,
    };
