// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) {
  return _ChatEntity.fromJson(json);
}

/// @nodoc
mixin _$ChatEntity {
  String get idUser => throw _privateConstructorUsedError;
  String get idChat => throw _privateConstructorUsedError;
  String get idTarget => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<MessageEntity> get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatEntityCopyWith<ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEntityCopyWith<$Res> {
  factory $ChatEntityCopyWith(
          ChatEntity value, $Res Function(ChatEntity) then) =
      _$ChatEntityCopyWithImpl<$Res, ChatEntity>;
  @useResult
  $Res call(
      {String idUser,
      String idChat,
      String idTarget,
      String target,
      String title,
      List<MessageEntity> messages});
}

/// @nodoc
class _$ChatEntityCopyWithImpl<$Res, $Val extends ChatEntity>
    implements $ChatEntityCopyWith<$Res> {
  _$ChatEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUser = null,
    Object? idChat = null,
    Object? idTarget = null,
    Object? target = null,
    Object? title = null,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as String,
      idChat: null == idChat
          ? _value.idChat
          : idChat // ignore: cast_nullable_to_non_nullable
              as String,
      idTarget: null == idTarget
          ? _value.idTarget
          : idTarget // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatEntityCopyWith<$Res>
    implements $ChatEntityCopyWith<$Res> {
  factory _$$_ChatEntityCopyWith(
          _$_ChatEntity value, $Res Function(_$_ChatEntity) then) =
      __$$_ChatEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String idUser,
      String idChat,
      String idTarget,
      String target,
      String title,
      List<MessageEntity> messages});
}

/// @nodoc
class __$$_ChatEntityCopyWithImpl<$Res>
    extends _$ChatEntityCopyWithImpl<$Res, _$_ChatEntity>
    implements _$$_ChatEntityCopyWith<$Res> {
  __$$_ChatEntityCopyWithImpl(
      _$_ChatEntity _value, $Res Function(_$_ChatEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUser = null,
    Object? idChat = null,
    Object? idTarget = null,
    Object? target = null,
    Object? title = null,
    Object? messages = null,
  }) {
    return _then(_$_ChatEntity(
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as String,
      idChat: null == idChat
          ? _value.idChat
          : idChat // ignore: cast_nullable_to_non_nullable
              as String,
      idTarget: null == idTarget
          ? _value.idTarget
          : idTarget // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatEntity implements _ChatEntity {
  const _$_ChatEntity(
      {required this.idUser,
      required this.idChat,
      this.idTarget = "",
      this.target = "",
      this.title = "",
      final List<MessageEntity> messages = const []})
      : _messages = messages;

  factory _$_ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$$_ChatEntityFromJson(json);

  @override
  final String idUser;
  @override
  final String idChat;
  @override
  @JsonKey()
  final String idTarget;
  @override
  @JsonKey()
  final String target;
  @override
  @JsonKey()
  final String title;
  final List<MessageEntity> _messages;
  @override
  @JsonKey()
  List<MessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatEntity(idUser: $idUser, idChat: $idChat, idTarget: $idTarget, target: $target, title: $title, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatEntity &&
            (identical(other.idUser, idUser) || other.idUser == idUser) &&
            (identical(other.idChat, idChat) || other.idChat == idChat) &&
            (identical(other.idTarget, idTarget) ||
                other.idTarget == idTarget) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idUser, idChat, idTarget, target,
      title, const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatEntityCopyWith<_$_ChatEntity> get copyWith =>
      __$$_ChatEntityCopyWithImpl<_$_ChatEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatEntityToJson(
      this,
    );
  }
}

abstract class _ChatEntity implements ChatEntity {
  const factory _ChatEntity(
      {required final String idUser,
      required final String idChat,
      final String idTarget,
      final String target,
      final String title,
      final List<MessageEntity> messages}) = _$_ChatEntity;

  factory _ChatEntity.fromJson(Map<String, dynamic> json) =
      _$_ChatEntity.fromJson;

  @override
  String get idUser;
  @override
  String get idChat;
  @override
  String get idTarget;
  @override
  String get target;
  @override
  String get title;
  @override
  List<MessageEntity> get messages;
  @override
  @JsonKey(ignore: true)
  _$$_ChatEntityCopyWith<_$_ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
