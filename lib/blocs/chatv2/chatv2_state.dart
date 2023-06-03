part of 'chatv2_bloc.dart';

class ChatV2State extends Equatable {
  const ChatV2State({
    this.isLoadingSetup = true,
    this.isOnVoice = false,
    this.isOpenChat = false,
    this.idChat = "",
    this.isTyping = false,
    this.errorMessage = "",
    this.route = "train",
  });

  final bool isLoadingSetup;
  final bool isOnVoice;
  final bool isOpenChat;
  final String idChat;
  final bool isTyping;
  final String errorMessage;
  final String route;

  @override
  List<Object?> get props => [
        isLoadingSetup,
        isOnVoice,
        isOpenChat,
        idChat,
        isTyping,
        errorMessage,
        route,
      ];

  ChatV2State copyWith({
    bool? isLoadingSetup,
    bool? isOnVoice,
    bool? isOpenChat,
    String? idChat,
    bool? isTyping,
    String? errorMessage,
    bool? isVoice,
    String? route,
  }) {
    return ChatV2State(
      isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
      isOnVoice: isOnVoice ?? this.isOnVoice,
      isOpenChat: isOpenChat ?? this.isOpenChat,
      idChat: idChat ?? this.idChat,
      isTyping: isTyping ?? this.isTyping,
      errorMessage: errorMessage ?? this.errorMessage,
      route: route ?? this.route,
    );
  }
}

class ChatV2InitialState extends ChatV2State {}
