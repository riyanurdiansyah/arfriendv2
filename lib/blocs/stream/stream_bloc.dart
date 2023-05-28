import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../api/firebase_service.dart';
import '../../api/firebase_service_impl.dart';

part 'stream_event.dart';
part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcQuestion = TextEditingController();

  StreamBloc() : super(StreamInitialState()) {
    on<StreamEvent>((event, emit) {});
    on<StreamSaveNewChatEvent>(_onSaveNewChat);
    on<StreamCreateNewChatEvent>(_onCreateNewChat);
    on<StreamOnTapHistoryEvent>(_onTapHistory);
  }

  FutureOr<void> _onSaveNewChat(
      StreamSaveNewChatEvent event, Emitter<StreamState> emit) async {
    final body = {};
    final response = await apiService.streamCreateChat({});
  }

  FutureOr<void> _onCreateNewChat(
      StreamCreateNewChatEvent event, Emitter<StreamState> emit) async {
    final body = {
      "idUser": FirebaseAuth.instance.currentUser!.uid,
      "idChat": const Uuid().v4(),
      "title": "New Chat",
      "createdAt": DateTime.now().toIso8601String(),
    };
    await apiService.createChat(body);
  }

  FutureOr<void> _onTapHistory(
      StreamOnTapHistoryEvent event, Emitter<StreamState> emit) {
    emit(state.copyWith(idChat: event.id));
  }
}
