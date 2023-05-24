import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_entity.freezed.dart';
part 'role_entity.g.dart';

@freezed
class RoleEntity with _$RoleEntity {
  const factory RoleEntity({
    required String id,
    required String role,
    required int roleId,
  }) = _RoleEntity;

  factory RoleEntity.fromJson(Map<String, dynamic> json) =>
      _$RoleEntityFromJson(json);
}
