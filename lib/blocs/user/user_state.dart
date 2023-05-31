part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.isLoading = true,
  });

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}

class UserInitialState extends UserState {}
