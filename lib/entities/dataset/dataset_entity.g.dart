// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataset_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DatasetEntity _$$_DatasetEntityFromJson(Map<String, dynamic> json) =>
    _$_DatasetEntity(
      addedBy: json['addedBy'] as String,
      createdAt: json['createdAt'] as String,
      id: json['id'] as String,
      messages:
          MessageEntity.fromJson(json['messages'] as Map<String, dynamic>),
      number: json['number'] as int,
      title: json['title'] as String,
      to: json['to'] as String,
      type: json['type'] as String,
      updatedAt: json['updatedAt'] as String,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$$_DatasetEntityToJson(_$_DatasetEntity instance) =>
    <String, dynamic>{
      'addedBy': instance.addedBy,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'messages': instance.messages,
      'number': instance.number,
      'title': instance.title,
      'to': instance.to,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'page': instance.page,
    };
