import 'package:arfriendv2/blocs/chatv2/chatv2_bloc.dart';
import 'package:arfriendv2/entities/chat/chat_entity.dart';
import 'package:arfriendv2/utils/app_text_normal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/validators.dart';
import 'web_animation_cursor.dart';
import 'web_chat_widget.dart';

class WebChatV2Page extends StatefulWidget {
  const WebChatV2Page({super.key});

  @override
  State<WebChatV2Page> createState() => _WebChatV2PageState();
}

class _WebChatV2PageState extends State<WebChatV2Page> {
  final _ChatV2Bloc = ChatV2Bloc();

  @override
  void initState() {
    _ChatV2Bloc.add(ChatV2InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<ChatV2Bloc>(
      create: (context) => _ChatV2Bloc,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  color: colorPrimary.withOpacity(0.7),
                  height: kToolbarHeight,
                  child: AppText.labelBold(
                    "History",
                    16,
                    Colors.black,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  color: Colors.amber,
                  margin:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () =>
                        _ChatV2Bloc.add(ChatV2CreateNewChatEvent()),
                    child: Text(
                      "+ New Chat",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: colorPrimaryDark,
                      ),
                    ),
                  ),
                ),
                StreamBuilder<List<ChatEntity>>(
                  stream: _ChatV2Bloc.apiService.streamHistoryChat(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    final data = snapshot.data ?? [];
                    return SingleChildScrollView(
                      child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                        builder: (context, state) {
                          return Column(
                            children: List.generate(
                              data.length,
                              (index) => ListTile(
                                selected: state.idChat == data[index].idChat,
                                selectedColor: Colors.grey,
                                selectedTileColor: Colors.grey.shade300,
                                onTap: () => _ChatV2Bloc.add(
                                    ChatV2OnTapHistoryEvent(
                                        data[index].idChat)),
                                hoverColor: Colors.grey.shade200,
                                leading: const Icon(
                                  Icons.message_rounded,
                                ),
                                title: AppTextNormal.labelW600(
                                  data[index].title,
                                  14,
                                  Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<ChatV2Bloc, ChatV2State>(
              builder: (context, state) {
                if (state.idChat.isEmpty) {
                  return const SizedBox();
                }
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    iconTheme: const IconThemeData(
                      color: Color(0xff004B7B),
                    ),
                    backgroundColor: const Color(0xFFDAF0FF),
                    title: Row(
                      children: [
                        Image.asset(
                          "assets/images/bot.webp",
                          width: 35,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        AppText.labelW600(
                          "ArBot",
                          18,
                          Colors.black,
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            _ChatV2Bloc.add(ChatV2OnTapHistoryEvent("")),
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    ],
                  ),
                  body: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: size.height,
                        child: Image.asset(
                          "assets/images/bg.webp",
                          fit: BoxFit.cover,
                        ),
                      ),
                      StreamBuilder(
                        builder: (context, snapshot) {
                          return StreamBuilder<ChatEntity>(
                            stream:
                                _ChatV2Bloc.apiService.streamChat(state.idChat),
                            builder: (context, snapshot) {
                              return SingleChildScrollView(
                                reverse: true,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0,
                                      right: 16,
                                      left: 16,
                                      bottom: 50),
                                  child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                                    builder: (context, state) {
                                      final data = snapshot.data?.messages
                                          .where((e) => e.role != "system")
                                          .toList();

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: List.generate(
                                              data?.length ?? 0,
                                              (index) {
                                                if (data![index].role ==
                                                    "user") {
                                                  return WebChatUserWidget(
                                                      data: data[index]);
                                                }
                                                return WebChatBotWidget(
                                                  data: data[index],
                                                  isLastMessage: (index ==
                                                          snapshot
                                                                  .data!
                                                                  .messages
                                                                  .length -
                                                              1 &&
                                                      !data[index].isRead),
                                                  onFinish: () {},
                                                );
                                              },
                                            ),
                                          ),
                                          state.isTyping
                                              ? const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 18.0),
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
                          );
                        },
                      )
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 65,
                    child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            if (!state.isOnVoice)
                              Expanded(
                                child: TextFormField(
                                  controller: _ChatV2Bloc.tcQuestion,
                                  validator: (val) =>
                                      Validators.requiredField(val!),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey.shade600,
                                  ),
                                  onEditingComplete: () => _ChatV2Bloc.add(
                                      ChatV2CheckMessagesInDBEvent()),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: GoogleFonts.montserrat(
                                      color: const Color(0xFFA2A4A8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 12),
                                    hintText: "Ketik pertanyaan...",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
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
                                    onPressed: () {},
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
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xFF0E85D1),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.mic_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
