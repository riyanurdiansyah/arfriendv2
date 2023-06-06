import 'dart:async';

import 'package:arfriendv2/entities/user/user_entity.dart';
import 'package:arfriendv2/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/firebase_service.dart';
import '../../api/firebase_service_impl.dart';
import '../../entities/role/role_entity.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final globalKey = GlobalKey<ScaffoldState>();

  final tcEmail = TextEditingController();
  final tcRole = TextEditingController();
  final tcNama = TextEditingController();
  int role = 99;

  UserBloc() : super(UserInitialState()) {
    on<UserEvent>((event, emit) {});
    on<UserInitialEvent>(_onInitial);
    on<UserGetDataEvent>(_onGetData);
    on<UserRegistEvent>(_onRegist);
    on<UserOnChangeRoleEvent>(_onChangeRole);
  }

  FutureOr<void> _onGetData(
      UserGetDataEvent event, Emitter<UserState> emit) async {
    final response = await apiService.getUsers();
    response.fold((l) => null, (data) {
      emit(state.copyWith(users: data, isLoadingSetup: false));
    });
  }

  FutureOr<void> _onInitial(UserInitialEvent event, Emitter<UserState> emit) {
    add(UserGetDataEvent());
  }

  FutureOr<void> _onRegist(
      UserRegistEvent event, Emitter<UserState> emit) async {
    Map<String, dynamic> body = {
      "email": tcEmail.text,
      "password": tcEmail.text.split("@")[0].trim(),
      "nama": tcNama.text,
    };
    final response = await apiService.regist(body);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Gagal menambahkan user"), (id) async {
      body.remove("password");
      body.addAll({
        "id": id,
        "role": role,
        "roleName": tcRole.text,
      });
      final resReg = await apiService.registUser(body);
      resReg.fold((l) => null, (r) {
        add(UserGetDataEvent());
        AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Berhasil menambahkan user");
      });
    });
  }

  FutureOr<void> _onChangeRole(
      UserOnChangeRoleEvent event, Emitter<UserState> emit) {
    tcRole.text = event.role.roleName;
    role = event.role.role;
  }
}
