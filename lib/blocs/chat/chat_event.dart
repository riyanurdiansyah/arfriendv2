part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class ChatOnAddedHistoryToVariableEvent extends ChatEvent {
  ChatOnAddedHistoryToVariableEvent(this.chat);

  final ChatEntity chat;
}

class ChatOnStreamHistoryEvent extends ChatEvent {}
