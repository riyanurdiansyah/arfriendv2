part of 'stream_bloc.dart';

class StreamState extends Equatable {
  const StreamState({
    this.isLoadingSetup = true,
    this.isOnVoice = false,
    this.isOpenChat = false,
    this.idChat = "",
    this.isTyping = false,
  });

  final bool isLoadingSetup;
  final bool isOnVoice;
  final bool isOpenChat;
  final String idChat;
  final bool isTyping;

  @override
  List<Object?> get props => [
        isLoadingSetup,
        isOnVoice,
        isOpenChat,
        idChat,
        isTyping,
      ];

  StreamState copyWith({
    bool? isLoadingSetup,
    bool? isOnVoice,
    bool? isOpenChat,
    String? idChat,
    bool? isTyping,
  }) {
    return StreamState(
      isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
      isOnVoice: isOnVoice ?? this.isOnVoice,
      isOpenChat: isOpenChat ?? this.isOpenChat,
      idChat: idChat ?? this.idChat,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class StreamInitialState extends StreamState {}
