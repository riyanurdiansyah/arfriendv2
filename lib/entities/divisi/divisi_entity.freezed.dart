// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'divisi_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DivisiEntity _$DivisiEntityFromJson(Map<String, dynamic> json) {
  return _DivisiEntity.fromJson(json);
}

/// @nodoc
mixin _$DivisiEntity {
  String get id => throw _privateConstructorUsedError;
  String get divisi => throw _privateConstructorUsedError;
  String get divisiId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DivisiEntityCopyWith<DivisiEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DivisiEntityCopyWith<$Res> {
  factory $DivisiEntityCopyWith(
          DivisiEntity value, $Res Function(DivisiEntity) then) =
      _$DivisiEntityCopyWithImpl<$Res, DivisiEntity>;
  @useResult
  $Res call({String id, String divisi, String divisiId});
}

/// @nodoc
class _$DivisiEntityCopyWithImpl<$Res, $Val extends DivisiEntity>
    implements $DivisiEntityCopyWith<$Res> {
  _$DivisiEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? divisi = null,
    Object? divisiId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      divisi: null == divisi
          ? _value.divisi
          : divisi // ignore: cast_nullable_to_non_nullable
              as String,
      divisiId: null == divisiId
          ? _value.divisiId
          : divisiId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DivisiEntityCopyWith<$Res>
    implements $DivisiEntityCopyWith<$Res> {
  factory _$$_DivisiEntityCopyWith(
          _$_DivisiEntity value, $Res Function(_$_DivisiEntity) then) =
      __$$_DivisiEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String divisi, String divisiId});
}

/// @nodoc
class __$$_DivisiEntityCopyWithImpl<$Res>
    extends _$DivisiEntityCopyWithImpl<$Res, _$_DivisiEntity>
    implements _$$_DivisiEntityCopyWith<$Res> {
  __$$_DivisiEntityCopyWithImpl(
      _$_DivisiEntity _value, $Res Function(_$_DivisiEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? divisi = null,
    Object? divisiId = null,
  }) {
    return _then(_$_DivisiEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      divisi: null == divisi
          ? _value.divisi
          : divisi // ignore: cast_nullable_to_non_nullable
              as String,
      divisiId: null == divisiId
          ? _value.divisiId
          : divisiId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DivisiEntity implements _DivisiEntity {
  const _$_DivisiEntity(
      {required this.id, required this.divisi, required this.divisiId});

  factory _$_DivisiEntity.fromJson(Map<String, dynamic> json) =>
      _$$_DivisiEntityFromJson(json);

  @override
  final String id;
  @override
  final String divisi;
  @override
  final String divisiId;

  @override
  String toString() {
    return 'DivisiEntity(id: $id, divisi: $divisi, divisiId: $divisiId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DivisiEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.divisi, divisi) || other.divisi == divisi) &&
            (identical(other.divisiId, divisiId) ||
                other.divisiId == divisiId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, divisi, divisiId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DivisiEntityCopyWith<_$_DivisiEntity> get copyWith =>
      __$$_DivisiEntityCopyWithImpl<_$_DivisiEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DivisiEntityToJson(
      this,
    );
  }
}

abstract class _DivisiEntity implements DivisiEntity {
  const factory _DivisiEntity(
      {required final String id,
      required final String divisi,
      required final String divisiId}) = _$_DivisiEntity;

  factory _DivisiEntity.fromJson(Map<String, dynamic> json) =
      _$_DivisiEntity.fromJson;

  @override
  String get id;
  @override
  String get divisi;
  @override
  String get divisiId;
  @override
  @JsonKey(ignore: true)
  _$$_DivisiEntityCopyWith<_$_DivisiEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
