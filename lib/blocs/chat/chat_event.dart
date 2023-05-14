part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class ChatOnAddedHistoryToVariableEvent extends ChatEvent {
  ChatOnAddedHistoryToVariableEvent(this.chat);

  final ChatEntity chat;
}

class ChatOnStreamChatEvent extends ChatEvent {}

class ChatOnStreamHistoryEvent extends ChatEvent {}

class ChatOnSendMessageEvent extends ChatEvent {}

class ChatOnTapHistoryIdEvent extends ChatEvent {
  ChatOnTapHistoryIdEvent(this.id);

  final String id;
}

class ChatOnDeleteHistoryMessageEvent extends ChatEvent {
  ChatOnDeleteHistoryMessageEvent(this.id);

  final String id;
}

class ChatOnCreateMessageEvent extends ChatEvent {}

class ChatOnGetListHistoryMessageEvent extends ChatEvent {}

class ChatOnUpdateIsReadEvent extends ChatEvent {
  ChatOnUpdateIsReadEvent(this.id);

  final String id;
}

class ChatOnChangeTypingEvent extends ChatEvent {
  ChatOnChangeTypingEvent(this.typing);

  final bool typing;
}

class ChatOnChangeTargetEvent extends ChatEvent {
  ChatOnChangeTargetEvent(this.target);

  final String target;
}

class ChatOnVoiceEvent extends ChatEvent {}

class ChatOnChangeStatusVoiceEvent extends ChatEvent {
  ChatOnChangeStatusVoiceEvent(this.isVoice);

  final bool isVoice;
}
