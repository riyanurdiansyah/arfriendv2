part of 'chatv2_bloc.dart';

abstract class ChatV2Event {}

class ChatV2InitialEvent extends ChatV2Event {}

class ChatV2CreateNewChatEvent extends ChatV2Event {
  ChatV2CreateNewChatEvent(this.listId);

  final List<String> listId;
}

class ChatV2SaveNewChatEvent extends ChatV2Event {}

class ChatV2SendMessageToGPTEvent extends ChatV2Event {}

class ChatV2UpdateNewChatFromGPTEvent extends ChatV2Event {}

class ChatV2OnTapHistoryEvent extends ChatV2Event {
  ChatV2OnTapHistoryEvent(this.id);

  final String id;
}

class ChatV2OnChangeRouteEvent extends ChatV2Event {
  ChatV2OnChangeRouteEvent(this.id, this.route);

  final String id;
  final String route;
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

class ChatV2OnVoiceEvent extends ChatV2Event {}

class ChatV2CheckTokenBeforeNewChatEvent extends ChatV2Event {}

class ChatV2OnChangeStatusVoiceEvent extends ChatV2Event {
  ChatV2OnChangeStatusVoiceEvent(this.isVoice);
  final bool isVoice;
}

class ChatV2OnUpdateListIdDatasetEvent extends ChatV2Event {
  ChatV2OnUpdateListIdDatasetEvent(this.listIdDataset);
  final List<String> listIdDataset;
}

class ChatV2CustomChatErrorMessageEvent extends ChatV2Event {
  ChatV2CustomChatErrorMessageEvent(this.chats);

  final List<MessageEntity> chats;
}
