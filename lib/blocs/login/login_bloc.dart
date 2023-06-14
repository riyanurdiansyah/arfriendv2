import 'dart:async';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user/user_entity.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcEmail = TextEditingController();
  final tcPassword = TextEditingController();
  late SharedPreferences _prefs;

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      _prefs = await SharedPreferences.getInstance();
    });
    on<LoginOnPressEvent>(_onPressLogin);
    on<LoginOnChangeStateSuccessEvent>(_onChangeStateSuccess);
    on<LoginSaveToSessionEvent>(_onSaveSession);
  }

  FutureOr<void> _onPressLogin(
      LoginOnPressEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final response = await apiService.login(tcEmail.text, tcPassword.text);
    response.fold((fail) => emit(LoginFailedState(fail.message)), (r) async {
      final id = FirebaseAuth.instance.currentUser!.uid;
      final user = await apiService.getUserById(id);
      user.fold((fail) => emit(LoginFailedState(fail.message)), (data) {
        add(LoginSaveToSessionEvent(data));
        add(LoginOnChangeStateSuccessEvent());
      });
    });
  }

  FutureOr<void> _onSaveSession(
      LoginSaveToSessionEvent event, Emitter<LoginState> emit) {
    _prefs.setString("id", event.user.id);
    _prefs.setString("nama", event.user.nama);
    _prefs.setInt("role", event.user.role);
    _prefs.setString("role_name", event.user.roleName);
    _prefs.setString("email", event.user.email);
  }

  FutureOr<void> _onChangeStateSuccess(
      LoginOnChangeStateSuccessEvent event, Emitter<LoginState> emit) {
    emit(LoginSuccessState());
  }
}
