// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sidebar_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidebarEntity _$SidebarEntityFromJson(Map<String, dynamic> json) {
  return _SidebarEntity.fromJson(json);
}

/// @nodoc
mixin _$SidebarEntity {
  String get title => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;
  int get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SidebarEntityCopyWith<SidebarEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidebarEntityCopyWith<$Res> {
  factory $SidebarEntityCopyWith(
          SidebarEntity value, $Res Function(SidebarEntity) then) =
      _$SidebarEntityCopyWithImpl<$Res, SidebarEntity>;
  @useResult
  $Res call({String title, String image, String route, int role});
}

/// @nodoc
class _$SidebarEntityCopyWithImpl<$Res, $Val extends SidebarEntity>
    implements $SidebarEntityCopyWith<$Res> {
  _$SidebarEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
    Object? route = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SidebarEntityCopyWith<$Res>
    implements $SidebarEntityCopyWith<$Res> {
  factory _$$_SidebarEntityCopyWith(
          _$_SidebarEntity value, $Res Function(_$_SidebarEntity) then) =
      __$$_SidebarEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String image, String route, int role});
}

/// @nodoc
class __$$_SidebarEntityCopyWithImpl<$Res>
    extends _$SidebarEntityCopyWithImpl<$Res, _$_SidebarEntity>
    implements _$$_SidebarEntityCopyWith<$Res> {
  __$$_SidebarEntityCopyWithImpl(
      _$_SidebarEntity _value, $Res Function(_$_SidebarEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
    Object? route = null,
    Object? role = null,
  }) {
    return _then(_$_SidebarEntity(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SidebarEntity implements _SidebarEntity {
  const _$_SidebarEntity(
      {required this.title,
      required this.image,
      required this.route,
      required this.role});

  factory _$_SidebarEntity.fromJson(Map<String, dynamic> json) =>
      _$$_SidebarEntityFromJson(json);

  @override
  final String title;
  @override
  final String image;
  @override
  final String route;
  @override
  final int role;

  @override
  String toString() {
    return 'SidebarEntity(title: $title, image: $image, route: $route, role: $role)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SidebarEntity &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, image, route, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SidebarEntityCopyWith<_$_SidebarEntity> get copyWith =>
      __$$_SidebarEntityCopyWithImpl<_$_SidebarEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SidebarEntityToJson(
      this,
    );
  }
}

abstract class _SidebarEntity implements SidebarEntity {
  const factory _SidebarEntity(
      {required final String title,
      required final String image,
      required final String route,
      required final int role}) = _$_SidebarEntity;

  factory _SidebarEntity.fromJson(Map<String, dynamic> json) =
      _$_SidebarEntity.fromJson;

  @override
  String get title;
  @override
  String get image;
  @override
  String get route;
  @override
  int get role;
  @override
  @JsonKey(ignore: true)
  _$$_SidebarEntityCopyWith<_$_SidebarEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
