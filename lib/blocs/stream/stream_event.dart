part of 'stream_bloc.dart';

abstract class StreamEvent {}

class StreamInitialEvent extends StreamEvent {}

class StreamCreateNewChatEvent extends StreamEvent {}

class StreamSaveNewChatEvent extends StreamEvent {}

class StreamSendMessageToGPTEvent extends StreamEvent {}

class StreamUpdateNewChatFromGPTEvent extends StreamEvent {}

class StreamOnTapHistoryEvent extends StreamEvent {
  StreamOnTapHistoryEvent(this.id);

  final String id;
}
