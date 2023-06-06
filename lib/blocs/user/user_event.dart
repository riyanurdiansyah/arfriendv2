part of 'user_bloc.dart';

abstract class UserEvent {}

class UserInitialEvent extends UserEvent {}

class UserGetDataEvent extends UserEvent {}

class UserRegistEvent extends UserEvent {}

class UserOnChangeRoleEvent extends UserEvent {
  UserOnChangeRoleEvent(this.role);

  final RoleEntity role;
}

class UserLogoutEvent extends UserEvent {}
