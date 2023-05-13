import 'dart:async';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcEmail = TextEditingController();
  final tcPassword = TextEditingController();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginOnPressEvent>(_onPressLogin);
  }

  FutureOr<void> _onPressLogin(
      LoginOnPressEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final response = await apiService.login(tcEmail.text, tcPassword.text);
    response.fold((fail) => emit(LoginFailedState(fail.message)),
        (r) => emit(LoginSuccessState()));
  }
}
