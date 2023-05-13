import 'dart:async';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/chat/chat_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcEmail = TextEditingController();
  final tcPassword = TextEditingController();

  StreamController<ChatEntity> streamController =
      StreamController<ChatEntity>.broadcast();

  ChatBloc() : super(ChatInitialState()) {
    on<ChatEvent>((event, emit) {});
    on<ChatInitialEvent>(_onInitial);
    on<ChatOnAddedHistoryToVariableEvent>(_onAddedHistory);
    on<ChatOnStreamHistoryEvent>(_onStreamHistory);
  }

  FutureOr<void> _onInitial(ChatInitialEvent event, Emitter<ChatState> emit) {
    add(ChatOnStreamHistoryEvent());
    emit(state.copyWith(isLoadingSetup: false));
  }

  Stream<ChatEntity> streamChat() {
    return apiService
        .streamHistoryChat(FirebaseAuth.instance.currentUser!.uid)
        .map((data) {
      add(ChatOnAddedHistoryToVariableEvent(data));
      return data;
    });
  }

  FutureOr<void> _onAddedHistory(
      ChatOnAddedHistoryToVariableEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(historyChat: event.chat, isLoadingSetup: false));
  }

  FutureOr<void> _onStreamHistory(
      ChatOnStreamHistoryEvent event, Emitter<ChatState> emit) {
    Stream<ChatEntity> stream =
        apiService.streamHistoryChat(FirebaseAuth.instance.currentUser!.uid);
    stream.listen((data) {
      streamController.add(data);
    });
  }
}
