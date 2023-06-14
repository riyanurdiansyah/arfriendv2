part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.isLoadingSetup = true,
    this.users = const [],
    this.listId = const [],
    this.user =
        const UserEntity(id: "", email: "", nama: "", role: 99, roleName: ""),
  });

  final bool isLoadingSetup;
  final List<UserEntity> users;
  final List<String> listId;
  final UserEntity user;

  UserState copyWith({
    bool? isLoadingSetup,
    List<UserEntity>? users,
    List<String>? listId,
    UserEntity? user,
  }) =>
      UserState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        users: users ?? this.users,
        listId: listId ?? this.listId,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        isLoadingSetup,
        users,
        listId,
        user,
      ];
}

class UserInitialState extends UserState {}

class UserLogoutState extends UserState {}

class UserNotAuthenticatedState extends UserState {}
