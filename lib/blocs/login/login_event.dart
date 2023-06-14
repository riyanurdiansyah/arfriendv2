part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginOnPressEvent extends LoginEvent {}

class LoginSaveToSessionEvent extends LoginEvent {
  LoginSaveToSessionEvent(this.user);
  final UserEntity user;
}

class LoginOnChangeStateSuccessEvent extends LoginEvent {}
