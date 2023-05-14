part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.isLoadingSetup = true,
    this.historyChat = const ChatEntity(idUser: "", idChat: "", messages: []),
    this.idChat = "",
    this.listHistory = const [],
    this.isTyping = false,
  });

  final bool isLoadingSetup;
  final ChatEntity historyChat;
  final String idChat;
  final List<ChatEntity> listHistory;
  final bool isTyping;

  ChatState copyWith({
    bool? isLoadingSetup,
    ChatEntity? historyChat,
    String? idChat,
    List<ChatEntity>? listHistory,
    bool? isTyping,
  }) =>
      ChatState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        historyChat: historyChat ?? this.historyChat,
        idChat: idChat ?? this.idChat,
        listHistory: listHistory ?? this.listHistory,
        isTyping: isTyping ?? this.isTyping,
      );

  @override
  List<Object?> get props => [
        isLoadingSetup,
        historyChat,
        idChat,
        listHistory,
        isTyping,
      ];
}

class ChatInitialState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatFailedState extends ChatState {
  const ChatFailedState(this.errorMessage);

  final String errorMessage;
}
