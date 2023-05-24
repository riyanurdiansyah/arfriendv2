// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoleEntity _$RoleEntityFromJson(Map<String, dynamic> json) {
  return _RoleEntity.fromJson(json);
}

/// @nodoc
mixin _$RoleEntity {
  String get id => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  int get roleId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoleEntityCopyWith<RoleEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleEntityCopyWith<$Res> {
  factory $RoleEntityCopyWith(
          RoleEntity value, $Res Function(RoleEntity) then) =
      _$RoleEntityCopyWithImpl<$Res, RoleEntity>;
  @useResult
  $Res call({String id, String role, int roleId});
}

/// @nodoc
class _$RoleEntityCopyWithImpl<$Res, $Val extends RoleEntity>
    implements $RoleEntityCopyWith<$Res> {
  _$RoleEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? roleId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoleEntityCopyWith<$Res>
    implements $RoleEntityCopyWith<$Res> {
  factory _$$_RoleEntityCopyWith(
          _$_RoleEntity value, $Res Function(_$_RoleEntity) then) =
      __$$_RoleEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String role, int roleId});
}

/// @nodoc
class __$$_RoleEntityCopyWithImpl<$Res>
    extends _$RoleEntityCopyWithImpl<$Res, _$_RoleEntity>
    implements _$$_RoleEntityCopyWith<$Res> {
  __$$_RoleEntityCopyWithImpl(
      _$_RoleEntity _value, $Res Function(_$_RoleEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? roleId = null,
  }) {
    return _then(_$_RoleEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoleEntity implements _RoleEntity {
  const _$_RoleEntity(
      {required this.id, required this.role, required this.roleId});

  factory _$_RoleEntity.fromJson(Map<String, dynamic> json) =>
      _$$_RoleEntityFromJson(json);

  @override
  final String id;
  @override
  final String role;
  @override
  final int roleId;

  @override
  String toString() {
    return 'RoleEntity(id: $id, role: $role, roleId: $roleId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoleEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.roleId, roleId) || other.roleId == roleId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, roleId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoleEntityCopyWith<_$_RoleEntity> get copyWith =>
      __$$_RoleEntityCopyWithImpl<_$_RoleEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoleEntityToJson(
      this,
    );
  }
}

abstract class _RoleEntity implements RoleEntity {
  const factory _RoleEntity(
      {required final String id,
      required final String role,
      required final int roleId}) = _$_RoleEntity;

  factory _RoleEntity.fromJson(Map<String, dynamic> json) =
      _$_RoleEntity.fromJson;

  @override
  String get id;
  @override
  String get role;
  @override
  int get roleId;
  @override
  @JsonKey(ignore: true)
  _$$_RoleEntityCopyWith<_$_RoleEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
