import 'package:arfriendv2/blocs/chatv2/chatv2_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../entities/chat/chat_entity.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_normal.dart';
import '../../../utils/validators.dart';
import '../web_animation_cursor.dart';
import '../web_chat_widget.dart';

class WebMainChatPage extends StatelessWidget {
  const WebMainChatPage({
    super.key,
    required this.chatV2Bloc,
  });

  final ChatV2Bloc chatV2Bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatV2Bloc, ChatV2State>(
      builder: (context, state) {
        return Scaffold(
          // key: chatV2Bloc.globalKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Color(0xff004B7B),
            ),
            backgroundColor: const Color(0xFFDAF0FF),
            leadingWidth: 28,
            leading: InkWell(
              focusColor: colorPrimary,
              hoverColor: colorPrimary,
              splashColor: colorPrimary,
              overlayColor: MaterialStateProperty.all(colorPrimary),
              highlightColor: colorPrimary,
              onTap: () => chatV2Bloc.add(ChatV2OnTapHistoryEvent("")),
              child: Image.asset(
                "assets/images/sidebar.webp",
              ),
            ),
            title: Row(
              children: [
                Image.asset(
                  "assets/images/bot.webp",
                  width: 35,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "ArBot",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: colorPrimaryDark,
                  ),
                ),
                if (state.isTyping)
                  AppTextNormal.labelW600(
                    "   -   ",
                    18,
                    Colors.black,
                  ),
                if (state.isTyping)
                  AppTextNormal.labelW600(
                    "Sedang mengetik...",
                    18,
                    Colors.black,
                  ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/bg.webp",
                  width: 350,
                ),
              ),
              StreamBuilder<ChatEntity>(
                stream: chatV2Bloc.apiService.streamChat(state.idChat),
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, right: 16, left: 16, bottom: 50),
                      child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                        builder: (context, state) {
                          final data = snapshot.data?.messages
                              .where((e) => e.hidden == false)
                              .toList();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: List.generate(
                                  data?.length ?? 0,
                                  (index) {
                                    if (data![index].role == "user") {
                                      return WebChatUserWidget(
                                          data: data[index]);
                                    }
                                    return WebChatBotWidget(
                                        data: data[index],
                                        isLastMessage: (index ==
                                                snapshot.data!.messages.length -
                                                    1 &&
                                            !data[index].isRead),
                                        onFinish: () => chatV2Bloc.add(
                                            ChatV2UpdateIsReadEvent(
                                                snapshot.data!.messages,
                                                index)));
                                  },
                                ),
                              ),
                              state.isTyping
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18.0),
                                      child: WebAnimationCursor(),
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            child: BlocBuilder<ChatV2Bloc, ChatV2State>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      color: colorPrimary,
                      child: Row(
                        children: [
                          if (!state.isOnVoice)
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  readOnly: state.isTyping,
                                  controller: chatV2Bloc.tcQuestion,
                                  validator: (val) =>
                                      Validators.requiredField(val!),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey.shade600,
                                  ),
                                  onEditingComplete: () => chatV2Bloc
                                      .add(ChatV2CheckMessagesInDBEvent()),
                                  decoration: InputDecoration(
                                    fillColor: colorPrimary,
                                    filled: true,
                                    hintStyle: GoogleFonts.montserrat(
                                      color: const Color(0xFFA2A4A8),
                                    ),
                                    // contentPadding:
                                    //     const EdgeInsets.symmetric(
                                    //         vertical: 0, horizontal: 12),
                                    hintText: "Ketik pertanyaan...",
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          if (!state.isOnVoice)
                            const SizedBox(
                              width: 12,
                            ),
                          if (state.isOnVoice)
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red,
                                ),
                                child: IconButton(
                                  onPressed: () =>
                                      chatV2Bloc.add(ChatV2OnVoiceEvent()),
                                  icon: const Icon(
                                    Icons.stop_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if (!state.isOnVoice)
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 35,
                              color: colorPrimary,
                              child: InkWell(
                                onTap: () =>
                                    chatV2Bloc.add(ChatV2OnVoiceEvent()),
                                child: Image.asset(
                                  "assets/images/mic.webp",
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
