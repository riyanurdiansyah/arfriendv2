part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.isLoadingSetup = true,
    this.users = const [],
    this.listId = const [],
  });

  final bool isLoadingSetup;
  final List<UserEntity> users;
  final List<String> listId;

  UserState copyWith({
    bool? isLoadingSetup,
    List<UserEntity>? users,
    List<String>? listId,
  }) =>
      UserState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        users: users ?? this.users,
        listId: listId ?? this.listId,
      );

  @override
  List<Object?> get props => [
        isLoadingSetup,
        users,
      ];
}

class UserInitialState extends UserState {}

class UserLogoutState extends UserState {}

class UserNotAuthenticatedState extends UserState {}
