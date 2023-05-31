import 'dart:async';

import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/dataset/message_entity.dart';
import 'package:arfriendv2/utils/app_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../api/firebase_service.dart';
import '../../api/firebase_service_impl.dart';
import '../../entities/dataset/dataset_entity.dart';

part 'chatv2_event.dart';
part 'chatv2_state.dart';

class ChatV2Bloc extends Bloc<ChatV2Event, ChatV2State> {
  final globalKey = GlobalKey<ScaffoldState>();
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcQuestion = TextEditingController();
  String apiKey = "";
  String idUser = "";

  ChatV2Bloc() : super(ChatV2InitialState()) {
    on<ChatV2Event>((event, emit) async {
      idUser = FirebaseAuth.instance.currentUser!.uid;
      final data = (await FirebaseFirestore.instance
          .collection("config")
          .doc("configs")
          .get());
      apiKey = data.data()!["api_key"];
    });
    on<ChatV2SaveNewChatEvent>(_onSaveNewChat);
    on<ChatV2CreateNewChatEvent>(_onCreateNewChat);
    on<ChatV2OnTapHistoryEvent>(_onTapHistory);

    on<ChatV2CheckMessagesInDBEvent>(_onCheckMessage);
    on<ChatV2AddMessageToDBEvent>(_onAddMessage);
    on<ChatV2DeleteHistoryEvent>(_onDeleteHistoryChat);
    on<ChatV2MessageToChatGPT>(_onMessageToChatGPT);
  }

  FutureOr<void> _onSaveNewChat(
      ChatV2SaveNewChatEvent event, Emitter<ChatV2State> emit) async {
    final body = {};
    // final response = await apiService.getHistoryChat({});
  }

  FutureOr<void> _onDeleteHistoryChat(
      ChatV2DeleteHistoryEvent event, Emitter<ChatV2State> emit) async {
    final response = await apiService.deleteHistoryById(event.id);
    response.fold((l) => null, (r) => add(ChatV2OnTapHistoryEvent("")));
  }

  ///ini buat create new history
  FutureOr<void> _onCreateNewChat(
      ChatV2CreateNewChatEvent event, Emitter<ChatV2State> emit) async {
    final id = const Uuid().v4();

    final count = (await FirebaseFirestore.instance
            .collection("chat")
            .where("idUser", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get())
        .docs
        .length;

    final body = {
      "idUser": FirebaseAuth.instance.currentUser!.uid,
      "idChat": id,
      "title": "New Chat",
      "number": count + 1,
      "createdAt": DateTime.now().toIso8601String(),
    };
    final response = await apiService.createChat(body);
    response.fold((l) => debugPrint("Error : ${l.message}"),
        (r) => add(ChatV2OnTapHistoryEvent(id)));
  }

  FutureOr<void> _onTapHistory(
      ChatV2OnTapHistoryEvent event, Emitter<ChatV2State> emit) {
    emit(state.copyWith(idChat: event.id));
  }

  FutureOr<void> _onCheckMessage(
      ChatV2CheckMessagesInDBEvent event, Emitter<ChatV2State> emit) async {
    final response = await apiService.getChats(state.idChat);
    response.fold((l) => null, (data) {
      if (data.messages.isNotEmpty) {
        add(ChatV2UpdateMessageToDBEvent());
      } else {
        add(ChatV2AddMessageToDBEvent(data));
      }
    });
  }

  FutureOr<void> _onAddMessage(
      ChatV2AddMessageToDBEvent event, Emitter<ChatV2State> emit) async {
    String text = tcQuestion.text;
    List<MessageEntity> messages = [];
    List<Map<String, dynamic>> messagesJson = [];
    messages = List.from(event.chat.messages);
    tcQuestion.clear();
    messages.add(MessageEntity(
      role: "user",
      content: text,
      isRead: true,
      date: DateTime.now().toIso8601String(),
      id: const Uuid().v4(),
    ));
    for (var data in messages) {
      messagesJson.add(data.toJson());
    }

    final response = await apiService.updateChat({
      "idChat": state.idChat,
      "title": text,
      "messages": messagesJson,
    });

    response.fold((l) => debugPrint("ERROR :=> ${l.message}"),
        (r) => add(ChatV2MessageToChatGPT()));
  }

  FutureOr<void> _onMessageToChatGPT(
      ChatV2MessageToChatGPT event, Emitter<ChatV2State> emit) async {
    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };
    final responseDataset = await apiService.getDataset();
    responseDataset.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Gagal memuat dataset..."), (data) async {
      //ambil data history chat terakhir
      //untuk diambil last message assistan jika ada
      final historyMessage = await FirebaseFirestore.instance
          .collection("chat")
          .doc(state.idChat)
          .get();
      final dataMessage = ChatEntity.fromJson(historyMessage.data()!);

      List<MessageEntity> messages = [];
      List<DatasetEntity> datasets =
          data.where((e) => e.to == "all" || e.to == idUser).toList();

      for (var d in datasets) {
        messages.add(d.messages);
      }

      if (dataMessage.messages.isNotEmpty) {
        messages.add(dataMessage.messages.last);
      }

      // print("INI D : $messages");

      final response = await apiService.sendMessageToChatGPT(headers, messages);
    });
  }
}
