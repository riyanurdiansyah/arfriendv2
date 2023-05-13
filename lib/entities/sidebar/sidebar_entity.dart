import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidebar_entity.freezed.dart';
part 'sidebar_entity.g.dart';

@freezed
class SidebarEntity with _$SidebarEntity {
  const factory SidebarEntity({
    required String title,
    required String image,
    required String route,
    required int role,
  }) = _SidebarEntity;

  factory SidebarEntity.fromJson(Map<String, dynamic> json) =>
      _$SidebarEntityFromJson(json);
}
