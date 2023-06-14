import 'dart:async';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:arfriendv2/utils/app_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';

import '../../entities/chat/chat_entity.dart';
import '../../entities/dataset/message_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final globalKey = GlobalKey<ScaffoldState>();
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcTitle = TextEditingController();
  final tcQuestion = TextEditingController();
  String apiKey = "";

  SpeechToText speech = SpeechToText();

  StreamController<ChatEntity> streamController =
      StreamController<ChatEntity>.broadcast();

  ChatBloc() : super(ChatInitialState()) {
    on<ChatEvent>((event, emit) {});
    on<ChatInitialEvent>(_onInitial);
    on<ChatOnAddedHistoryToVariableEvent>(_onAddedHistory);
    on<ChatOnStreamChatEvent>(_onStreamChat);
    on<ChatOnSendMessageEvent>(_onSendMessage);
    on<ChatOnTapHistoryIdEvent>(_onTapIdHistory);
    on<ChatOnCreateMessageEvent>(_onCreateMessage);
    on<ChatOnGetListHistoryMessageEvent>(_onGetListHistory);
    on<ChatOnDeleteHistoryMessageEvent>(_onDeleteHistoryChat);
    on<ChatOnUpdateIsReadEvent>(_onUpdateIsRead);
    on<ChatOnChangeTypingEvent>(_onChangeTyping);
    on<ChatOnChangeTargetEvent>(_onChangeTarget);
    on<ChatOnVoiceEvent>(_onVoice);
    on<ChatOnChangeStatusVoiceEvent>(_onChangeStatusVoice);
  }

  FutureOr<void> _onInitial(
      ChatInitialEvent event, Emitter<ChatState> emit) async {
    final data = (await FirebaseFirestore.instance
        .collection("config")
        .doc("configs")
        .get());
    apiKey = data.data()!["api_key"];
    add(ChatOnGetListHistoryMessageEvent());
    add(ChatOnStreamHistoryEvent());
    emit(state.copyWith(isLoadingSetup: false));
  }

  FutureOr<void> _onAddedHistory(
      ChatOnAddedHistoryToVariableEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(historyChat: event.chat, isLoadingSetup: false));
  }

  FutureOr<void> _onStreamChat(
      ChatOnStreamChatEvent event, Emitter<ChatState> emit) {
    Stream<ChatEntity> stream =
        apiService.streamChat(FirebaseAuth.instance.currentUser!.uid);
    stream.listen((data) {
      streamController.add(data);
    });
  }

  FutureOr<void> _onSendMessage(
      ChatOnSendMessageEvent event, Emitter<ChatState> emit) async {
    List<Map<String, dynamic>> messagesJson = [];
    List<MessageEntity> listMessage = [];
    List<MessageEntity> listMessageForGTP = [];
    List<Map<String, dynamic>> upMessage = [];
    List<MessageEntity> listUpMessage = [];

    final checkData = (await FirebaseFirestore.instance
        .collection("chat")
        .doc(state.idChat)
        .get());
    // responseDataset.fold(
    //     (l) => ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
    //           SnackBar(
    //             backgroundColor: Colors.red,
    //             duration: const Duration(seconds: 2),
    //             width: AppResponsive.isDesktop(globalKey.currentContext!)
    //                 ? MediaQuery.of(globalKey.currentContext!).size.width / 4
    //                 : AppResponsive.isTablet(globalKey.currentContext!)
    //                     ? MediaQuery.of(globalKey.currentContext!).size.width /
    //                         2
    //                     : MediaQuery.of(globalKey.currentContext!).size.width /
    //                         1.5,
    //             behavior: SnackBarBehavior.floating,
    //             content: AppText.labelW600(
    //               "Gagal mengundah dataset",
    //               14,
    //               Colors.white,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //         ), (dataset) async {

    if (checkData.exists) {
      if (checkData.data()?["messages"] != null) {
        final dataList = checkData.data()?["messages"] as List<dynamic>;
        for (var data in dataList) {
          listMessage.add(MessageEntity.fromJson(data));
        }
      } else {
        final responseDataset = await apiService.getDataset();
        responseDataset.fold((l) => null, (dataset) {
          for (var data in dataset) {
            listMessage.add(data.messages);
          }
        });
      }
      final id = const Uuid().v4();
      listMessage.add(
        MessageEntity(
          role: "user",
          content: tcQuestion.text,
          hidden: false,
          date: DateTime.now().toIso8601String(),
          isRead: true,
          id: id,
        ),
      );
      tcQuestion.clear();

      for (var data in listMessage) {
        messagesJson.add(data.toJson());
      }
      final updateChatDB = await apiService.updateChat({
        "idChat": state.idChat,
        "messages": messagesJson,
      });

      final headers = {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      };

      updateChatDB.fold(
          (fail) => AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title: fail.message), (r) async {
        add(ChatOnChangeTypingEvent(true));
        listMessageForGTP =
            listMessage.where((e) => e.role == "system").toSet().toList();
        listMessageForGTP.add(listMessage[listMessage.length - 1]);
        final response = await apiService.sendMessageToChatGPT(
            headers, listMessageForGTP, "", 0);
        response.fold((_) => add(ChatOnChangeTypingEvent(false)), (data) async {
          final checkData = (await FirebaseFirestore.instance
              .collection("chat")
              .doc(state.idChat)
              .get());
          if (checkData.exists) {
            if (checkData.data()?["messages"] != null) {
              final dataList = checkData.data()?["messages"] as List<dynamic>;
              for (var data in dataList) {
                listUpMessage.add(MessageEntity.fromJson(data));
              }
            }
          }
          for (var data in listUpMessage) {
            upMessage.add(data.toJson());
          }
          upMessage.add(data.toJson());
          add(ChatOnChangeTypingEvent(false));
          await apiService.updateChat({
            "idChat": state.idChat,
            "messages": upMessage,
          });
          messagesJson.clear();
          listUpMessage.clear();
          listMessage.clear();
          listMessageForGTP.clear();
        });
      });
    }
    // });
  }

  FutureOr<void> _onTapIdHistory(
      ChatOnTapHistoryIdEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(idChat: event.id));
  }

  FutureOr<void> _onCreateMessage(
      ChatOnCreateMessageEvent event, Emitter<ChatState> emit) async {
    final body = {
      "idUser": FirebaseAuth.instance.currentUser!.uid,
      "idChat": const Uuid().v4(),
      "title": tcTitle.text,
      "target": state.target.isEmpty ? "all" : state.target,
      "idTarget": "",
    };
    tcTitle.clear();
    await apiService.createChat(body);
    add(ChatOnGetListHistoryMessageEvent());
  }

  FutureOr<void> _onGetListHistory(
      ChatOnGetListHistoryMessageEvent event, Emitter<ChatState> emit) async {
    final response =
        await apiService.getHistoryChat(FirebaseAuth.instance.currentUser!.uid);
    response.fold(
        (l) => null, (data) => emit(state.copyWith(listHistory: data)));
  }

  FutureOr<void> _onDeleteHistoryChat(
      ChatOnDeleteHistoryMessageEvent event, Emitter<ChatState> emit) async {
    final response = await apiService.deleteHistoryById(event.id);
    response.fold((l) => null, (r) => add(ChatOnGetListHistoryMessageEvent()));
  }

  FutureOr<void> _onUpdateIsRead(
      ChatOnUpdateIsReadEvent event, Emitter<ChatState> emit) async {
    List<Map<String, dynamic>> messagesJson = [];
    List<MessageEntity> listMessage = [];
    final checkData = (await FirebaseFirestore.instance
        .collection("chat")
        .doc(state.idChat)
        .get());
    if (checkData.exists) {
      final dataList = checkData.data()?["messages"] as List<dynamic>;
      for (var data in dataList) {
        listMessage.add(MessageEntity.fromJson(data));
      }
      listMessage[listMessage.indexWhere((e) => e.id == event.id)] =
          listMessage[listMessage.indexWhere((e) => e.id == event.id)]
              .copyWith(isRead: true);

      for (var data in listMessage) {
        messagesJson.add(data.toJson());
      }
      await apiService.updateChat({
        "idChat": state.idChat,
        "messages": messagesJson,
      });
    }
  }

  FutureOr<void> _onChangeTyping(
      ChatOnChangeTypingEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(isTyping: event.typing));
  }

  FutureOr<void> _onChangeTarget(
      ChatOnChangeTargetEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(target: event.target));
  }

  FutureOr<void> _onVoice(
      ChatOnVoiceEvent event, Emitter<ChatState> emit) async {
    if (state.isVoice) {
      add(ChatOnChangeStatusVoiceEvent(false));
      speech.stop();
      add(ChatOnSendMessageEvent());
    } else {
      final ava = await speech.initialize();
      if (ava) {
        speech.listen(
          localeId: "id_ID",
          onResult: (result) {
            debugPrint("HASIL : ${result.recognizedWords}");
            tcQuestion.text = result.recognizedWords;
          },
        );
        add(ChatOnChangeStatusVoiceEvent(true));
      }
    }
  }

  FutureOr<void> _onChangeStatusVoice(
      ChatOnChangeStatusVoiceEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(isVoice: event.isVoice));
  }
}
