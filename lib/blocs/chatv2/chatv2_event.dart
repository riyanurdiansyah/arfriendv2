part of 'chatv2_bloc.dart';

abstract class ChatV2Event {}

class ChatV2InitialEvent extends ChatV2Event {}

class ChatV2CreateNewChatEvent extends ChatV2Event {}

class ChatV2SaveNewChatEvent extends ChatV2Event {}

class ChatV2SendMessageToGPTEvent extends ChatV2Event {}

class ChatV2UpdateNewChatFromGPTEvent extends ChatV2Event {}

class ChatV2OnTapHistoryEvent extends ChatV2Event {
  ChatV2OnTapHistoryEvent(this.id);

  final String id;
}

class ChatV2CheckMessagesInDBEvent extends ChatV2Event {}

class ChatV2AddMessageToDBEvent extends ChatV2Event {
  final ChatEntity chat;
  ChatV2AddMessageToDBEvent(this.chat);
}

class ChatV2UpdateMessageToDBEvent extends ChatV2Event {}
