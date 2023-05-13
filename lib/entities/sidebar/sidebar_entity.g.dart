// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SidebarEntity _$$_SidebarEntityFromJson(Map<String, dynamic> json) =>
    _$_SidebarEntity(
      title: json['title'] as String,
      image: json['image'] as String,
      route: json['route'] as String,
      role: json['role'] as int,
    );

Map<String, dynamic> _$$_SidebarEntityToJson(_$_SidebarEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'route': instance.route,
      'role': instance.role,
    };
