import 'dart:async';

import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/entities/dataset/message_entity.dart';
import 'package:arfriendv2/utils/app_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
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
  String model = "";
  int tokens = 0;
  double temperature = 0.5;
  SpeechToText speech = SpeechToText();

  ChatV2Bloc() : super(ChatV2InitialState()) {
    on<ChatV2Event>((event, emit) async {
      idUser = FirebaseAuth.instance.currentUser!.uid;
      final data = (await FirebaseFirestore.instance
          .collection("config")
          .doc("configs")
          .get());
      apiKey = data.data()!["api_key"];
      model = data.data()?["model"] ?? "gpt-3.5-turbo";
      tokens = data.data()?["tokens"] ?? 500;
      temperature = data.data()?["temperature"] ?? 0.5;
    });
    on<ChatV2SaveNewChatEvent>(_onSaveNewChat);
    on<ChatV2CreateNewChatEvent>(_onCreateNewChat);
    on<ChatV2OnTapHistoryEvent>(_onTapHistory);

    on<ChatV2CheckMessagesInDBEvent>(_onCheckMessage);
    on<ChatV2AddMessageToDBEvent>(_onAddMessage);
    on<ChatV2DeleteHistoryEvent>(_onDeleteHistoryChat);
    on<ChatV2MessageToChatGPTEvent>(_onMessageToChatGPT);
    on<ChatV2MessageToChatGPTFirstEvent>(_onMessageToChatGPTFirst);
    on<ChatV2UpdateIsReadEvent>(_onUpdateIsRead);
    on<ChatV2ChangeTypingEvent>(_onChangeTyping);
    on<ChatV2AddErrorMessageEvent>(_onAddErrorMessage);
    on<ChatV2UpdateMessageToDBEvent>(_onUpdateMessageToDB);
    on<ChatV2OnVoiceEvent>(_onVoice);
    on<ChatV2OnChangeStatusVoiceEvent>(_onChangeStatusVoice);
    on<ChatV2OnChangeRouteEvent>(_onChangeRoute);
    on<ChatV2CheckTokenBeforeNewChatEvent>(_onCheckTokenBeforeNewChat);
    on<ChatV2OnUpdateListIdDatasetEvent>(_onUpdateListIdDataset);
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
      "listIdDataset": event.listId,
      "title": "New Chat",
      "number": count + 1,
      "createdAt": DateTime.now().toIso8601String(),
    };
    final response = await apiService.createChat(body);
    response.fold((l) => debugPrint("Error : ${l.message}"), (r) {
      add(ChatV2OnTapHistoryEvent(id));
      add(ChatV2MessageToChatGPTFirstEvent());
    });
  }

  FutureOr<void> _onTapHistory(
      ChatV2OnTapHistoryEvent event, Emitter<ChatV2State> emit) {
    emit(state.copyWith(idChat: event.id));
  }

  FutureOr<void> _onCheckMessage(
      ChatV2CheckMessagesInDBEvent event, Emitter<ChatV2State> emit) async {
    final response = await apiService.getChats(state.idChat);
    response.fold((l) => null, (data) {
      // if (data.messages.isNotEmpty) {
      //   add(ChatV2UpdateMessageToDBEvent());
      // } else {
      add(ChatV2AddMessageToDBEvent(data));
      // }
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
      "title":
          event.chat.messages.where((e) => e.role == "user").toList().isEmpty
              ? text
              : event.chat.title,
      "messages": messagesJson,
    });

    response.fold((l) => debugPrint("ERROR :=> ${l.message}"), (r) {
      tcQuestion.clear();
      add(ChatV2ChangeTypingEvent(true));
      add(ChatV2MessageToChatGPTEvent());
    });
  }

  FutureOr<void> _onMessageToChatGPT(
      ChatV2MessageToChatGPTEvent event, Emitter<ChatV2State> emit) async {
    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };
    //ambil data history chat terakhir
    //untuk diambil last message assistan jika ada
    final historyMessage = await FirebaseFirestore.instance
        .collection("chat")
        .doc(state.idChat)
        .get();
    final responseDataset = await apiService.getDataset();
    final dataMessage = ChatEntity.fromJson(historyMessage.data()!);

    ///cek jika ada perintah khusus
    if (dataMessage.messages.last.content.contains("##")) {
      ///jika meminta perintah lanjutkan
      ///tp tidak ada history dari assistant
      if (dataMessage.messages
              .where((e) => e.role == "assistant")
              .toList()
              .length <=
          2) {
        List<MessageEntity> messages = List.from(dataMessage.messages);
        List<Map<String, dynamic>> messagesJson = [];
        tcQuestion.clear();
        messages.add(MessageEntity(
          role: "system",
          content: "Maaf anda tidak memiliki kalimat yang bisa dilanjutkan.",
          isRead: false,
          hidden: false,
          date: DateTime.now().toIso8601String(),
          id: const Uuid().v4(),
        ));
        for (var data in messages) {
          messagesJson.add(data.toJson());
        }
        final response = await apiService.updateChat({
          "idChat": state.idChat,
          "messages": messagesJson,
        });
        response.fold((l) => add(ChatV2AddErrorMessageEvent(l.message)),
            (r) => add(ChatV2ChangeTypingEvent(false)));
      } else {
        ///PROSES LANJUTKAN TEXT TERPOTONG
        List<MessageEntity> messages = [];

        if (dataMessage.messages.isNotEmpty) {
          messages.add(dataMessage.messages
              .where((e) => e.role == "assistant")
              .toList()
              .last);
        }

        final response = await apiService.sendMessageToChatGPT(
            headers, messages, model, tokens);

        response.fold((l) {
          add(ChatV2ChangeTypingEvent(false));
        }, (chat) async {
          List<Map<String, dynamic>> messagesJson = [];
          List<MessageEntity> messagesUp = [];
          final dataJson = (await FirebaseFirestore.instance
              .collection("chat")
              .doc(state.idChat)
              .get());
          final dataChat = ChatEntity.fromJson(dataJson.data()!);
          messagesUp = List.from(dataChat.messages);
          messagesUp.add(MessageEntity(
            role: chat.role,
            content: chat.content,
            isRead: false,
            date: chat.date,
            id: chat.id,
            token: chat.token,
          ));
          for (var data in messagesUp) {
            messagesJson.add(data.toJson());
          }
          await apiService.updateChat({
            "idChat": state.idChat,
            "messages": messagesJson,
          });

          add(ChatV2ChangeTypingEvent(false));
        });
      }
    } else {
      responseDataset.fold(
          (l) => AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title: "Gagal memuat dataset..."), (data) async {
        List<MessageEntity> messages = [];
        List<DatasetEntity> datasets = data
            .where((e) => (((e.to.toLowerCase() == "all" || e.to == idUser) &&
                    dataMessage.listIdDataset.contains(e.id)) ||
                e.to.toLowerCase() == "system"))
            .toList();

        // if (dataMessage.messages
        //     .where((e) => e.role == "assistant")
        //     .last
        //     .content
        //     .toLowerCase()
        //     .contains(dataMessage.messages.last.content)) {
        //   print("WASU");
        // }

        for (var d in datasets) {
          messages.add(d.messages);
        }

        if (dataMessage.messages
            .where((e) => e.role == "assistant")
            .isNotEmpty) {
          messages.add(
              dataMessage.messages.where((e) => e.role == "assistant").last);
        }

        if (dataMessage.messages.where((e) => e.role == "user").isNotEmpty) {
          messages.add(dataMessage.messages.last);
        }

        final response = await apiService.sendMessageToChatGPT(
            headers, messages, model, tokens);

        response.fold((l) {
          add(ChatV2ChangeTypingEvent(false));
        }, (chat) async {
          List<Map<String, dynamic>> messagesJson = [];
          List<MessageEntity> messagesUp = [];
          final dataJson = (await FirebaseFirestore.instance
              .collection("chat")
              .doc(state.idChat)
              .get());
          final dataChat = ChatEntity.fromJson(dataJson.data()!);
          messagesUp = List.from(dataChat.messages);
          messagesUp.add(MessageEntity(
            role: chat.role,
            content: chat.content,
            isRead: false,
            date: chat.date,
            id: chat.id,
            token: chat.token,
          ));
          for (var data in messagesUp) {
            messagesJson.add(data.toJson());
          }
          await apiService.updateChat({
            "idChat": state.idChat,
            "messages": messagesJson,
          });

          add(ChatV2ChangeTypingEvent(false));
        });
      });
    }
  }

  FutureOr<void> _onMessageToChatGPTFirst(
      ChatV2MessageToChatGPTFirstEvent event, Emitter<ChatV2State> emit) async {
    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    List<MessageEntity> messages = [
      const MessageEntity(
          role: "system",
          content:
              "berikan kalimat motivasi semangat untuk hari ini maksimal 30 kata")
    ];

    final response = await apiService.sendMessageToChatGPT(
        headers, messages, model, tokens,
        temperature: 1.0);
    response.fold((l) => null, (data) async {
      List<MessageEntity> messages = [];
      List<Map<String, dynamic>> messagesJson = [];
      tcQuestion.clear();
      messages.add(MessageEntity(
        role: "assistant",
        content: data.content,
        isRead: false,
        hidden: false,
        date: data.date,
        id: data.id,
        token: data.token,
      ));
      for (var data in messages) {
        messagesJson.add(data.toJson());
      }
      final response = await apiService.updateChat({
        "idChat": state.idChat,
        "messages": messagesJson,
      });
      response.fold((l) => add(ChatV2AddErrorMessageEvent(l.message)),
          (r) => add(ChatV2ChangeTypingEvent(false)));
    });
  }

  FutureOr<void> _onUpdateIsRead(
      ChatV2UpdateIsReadEvent event, Emitter<ChatV2State> emit) async {
    List<MessageEntity> messages = List.from(event.messages);
    List<Map<String, dynamic>> upMessage = [];
    messages[event.index] = MessageEntity(
      role: messages[event.index].role,
      content: messages[event.index].content,
      date: messages[event.index].date,
      isRead: true,
      hidden: false,
      id: messages[event.index].id,
    );

    for (var data in messages) {
      upMessage.add(data.toJson());
    }
    await apiService.updateChat({
      "idChat": state.idChat,
      "messages": upMessage,
    });
  }

  FutureOr<void> _onChangeTyping(
      ChatV2ChangeTypingEvent event, Emitter<ChatV2State> emit) {
    emit(state.copyWith(isTyping: event.isTyping));
  }

  FutureOr<void> _onAddErrorMessage(
      ChatV2AddErrorMessageEvent event, Emitter<ChatV2State> emit) {
    emit(state.copyWith(
      isTyping: event.isTyping ?? false,
    ));
  }

  FutureOr<void> _onUpdateMessageToDB(
      ChatV2UpdateMessageToDBEvent event, Emitter<ChatV2State> emit) async {}

  FutureOr<void> _onVoice(
      ChatV2OnVoiceEvent event, Emitter<ChatV2State> emit) async {
    if (state.isOnVoice) {
      speech.stop();
      add(ChatV2OnChangeStatusVoiceEvent(false));
      Future.delayed(const Duration(seconds: 1), () {
        add(ChatV2CheckMessagesInDBEvent());
      });
    } else {
      final ava = await speech.initialize();
      if (ava) {
        speech.listen(
          onResult: (result) {
            tcQuestion.text = result.recognizedWords;
          },
          listenMode: ListenMode.confirmation,
          localeId: "id_ID",
        );
        add(ChatV2OnChangeStatusVoiceEvent(true));
      }
    }
  }

  FutureOr<void> _onChangeStatusVoice(
      ChatV2OnChangeStatusVoiceEvent event, Emitter<ChatV2State> emit) {
    emit(state.copyWith(isOnVoice: event.isVoice));
  }

  FutureOr<void> _onChangeRoute(
      ChatV2OnChangeRouteEvent event, Emitter<ChatV2State> emit) {
    emit(state.copyWith(idChat: event.id, route: event.route));
  }

  FutureOr<void> _onCheckTokenBeforeNewChat(
      ChatV2CheckTokenBeforeNewChatEvent event,
      Emitter<ChatV2State> emit) async {
    final cekToken =
        (await FirebaseFirestore.instance.collection("dataset").get()).docs;

    int token = 0;

    List<DatasetEntity> dataset = [];
    for (var data in cekToken) {
      dataset.add(DatasetEntity.fromJson(data.data()));
    }

    for (var cek in dataset) {
      token += cek.token;
    }

    if (token > 4000) {
      AppDialog.dialogChoosDataset(
          context: globalKey.currentContext!,
          listData: dataset,
          onTap: (data) {
            add(ChatV2CreateNewChatEvent(data));
          });
    } else {
      List<String> listIdDataset = [];
      for (var data in dataset) {
        listIdDataset.add(data.id);
      }
      add(ChatV2CreateNewChatEvent(listIdDataset));
    }
  }

  FutureOr<void> _onUpdateListIdDataset(
      ChatV2OnUpdateListIdDatasetEvent event, Emitter<ChatV2State> emit) async {
    final response = await apiService.updateChat({
      "idChat": state.idChat,
      "listIdDataset": event.listIdDataset,
    });

    response.fold(
      (l) => AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Gagal memperbarui dataset"),
      (r) {},
    );
  }
}
