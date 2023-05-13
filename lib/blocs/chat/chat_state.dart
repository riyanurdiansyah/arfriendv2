part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.isLoadingSetup = true,
    this.historyChat = const ChatEntity(id: "", messages: []),
  });

  final bool isLoadingSetup;
  final ChatEntity historyChat;

  ChatState copyWith({
    bool? isLoadingSetup,
    ChatEntity? historyChat,
  }) =>
      ChatState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        historyChat: historyChat ?? this.historyChat,
      );

  @override
  List<Object?> get props => [
        isLoadingSetup,
        historyChat,
      ];
}

class ChatInitialState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatFailedState extends ChatState {
  const ChatFailedState(this.errorMessage);

  final String errorMessage;
}
