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

class ChatV2MessageToChatGPTEvent extends ChatV2Event {}

class ChatV2MessageToChatGPTFirstEvent extends ChatV2Event {}

class ChatV2UpdateMessageToDBEvent extends ChatV2Event {}

class ChatV2UpdateIsReadEvent extends ChatV2Event {
  ChatV2UpdateIsReadEvent(this.messages, this.index);

  final List<MessageEntity> messages;
  final int index;
}

class ChatV2DeleteHistoryEvent extends ChatV2Event {
  ChatV2DeleteHistoryEvent(this.id);

  final String id;
}

class ChatV2ChangeTypingEvent extends ChatV2Event {
  ChatV2ChangeTypingEvent(this.isTyping);

  final bool isTyping;
}

class ChatV2AddErrorMessageEvent extends ChatV2Event {
  ChatV2AddErrorMessageEvent(
    this.errorMessage, {
    this.isTyping,
  });

  final String errorMessage;
  bool? isTyping;
}
