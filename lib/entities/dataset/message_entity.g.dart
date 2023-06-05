// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageEntity _$$_MessageEntityFromJson(Map<String, dynamic> json) =>
    _$_MessageEntity(
      role: json['role'] as String,
      content: json['content'] as String,
      hidden: json['hidden'] as bool? ?? false,
      id: json['id'] as String? ?? "",
      isRead: json['isRead'] as bool? ?? false,
      date: json['date'] as String? ?? "",
      token: json['token'] as int? ?? 0,
    );

Map<String, dynamic> _$$_MessageEntityToJson(_$_MessageEntity instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
      'hidden': instance.hidden,
      'id': instance.id,
      'isRead': instance.isRead,
      'date': instance.date,
      'token': instance.token,
    };
