import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_entity.freezed.dart';
part 'role_entity.g.dart';

@freezed
class RoleEntity with _$RoleEntity {
  const factory RoleEntity({
    required String id,
    required int role,
    required String roleName,
  }) = _RoleEntity;

  factory RoleEntity.fromJson(Map<String, dynamic> json) =>
      _$RoleEntityFromJson(json);
}
