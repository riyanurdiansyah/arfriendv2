import 'package:arfriendv2/pages/web/web_animation_cursor.dart';
import 'package:arfriendv2/pages/web/web_side_bar.dart';
import 'package:arfriendv2/utils/app_color.dart';
import 'package:arfriendv2/utils/app_dialog.dart';
import 'package:arfriendv2/utils/app_responsive.dart';
import 'package:arfriendv2/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../entities/chat/chat_entity.dart';
import '../../utils/validators.dart';
import 'web_chat_widget.dart';

class WebChatPage extends StatefulWidget {
  const WebChatPage({
    super.key,
    required this.route,
  });

  final String route;

  @override
  State<WebChatPage> createState() => _WebChatPageState();
}

class _WebChatPageState extends State<WebChatPage> {
  final _chatBloc = ChatBloc();

  @override
  void initState() {
    _chatBloc.add(ChatInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _chatBloc,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: colorPrimary.withOpacity(0.7),
                automaticallyImplyLeading: false,
                title: AppText.labelW600(
                  "History",
                  14,
                  Colors.black,
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      AppDialog.dialogAddChat(
                          context: context, chatBloc: _chatBloc);
                    },
                    icon: const Icon(
                      Icons.add_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              body: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return Column(
                    children: List.generate(
                      state.listHistory.length,
                      (index) => ListTile(
                        onLongPress: () => _chatBloc.add(
                            ChatOnDeleteHistoryMessageEvent(
                                state.listHistory[index].idChat)),
                        onTap: () => _chatBloc.add(ChatOnTapHistoryIdEvent(
                            state.listHistory[index].idChat)),
                        title: Text(
                          state.listHistory[index].target,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          state.listHistory[index].title,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.idChat.isEmpty) {
                  return Container(
                    color: Colors.blue,
                  );
                }
                return Scaffold(
                  key: _chatBloc.globalKey,
                  endDrawer: AppResponsive.isMobile(context)
                      ? SideNavbar(route: widget.route)
                      : null,
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
                      BlocBuilder<ChatBloc, ChatState>(
                        builder: (context, state) {
                          if (state.isLoadingSetup) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SpinKitThreeInOut(
                                  color: Color(0xff004B7B),
                                  size: 25.0,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                AppText.labelW500(
                                  "Memuat chat...",
                                  16,
                                  Colors.grey,
                                ),
                              ],
                            );
                          }
                          return StreamBuilder<ChatEntity>(
                            stream:
                                _chatBloc.apiService.streamChat(state.idChat),
                            builder: (context, snapshot) {
                              return SingleChildScrollView(
                                reverse: true,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0,
                                      right: 16,
                                      left: 16,
                                      bottom: 50),
                                  child: BlocBuilder<ChatBloc, ChatState>(
                                    builder: (context, state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: List.generate(
                                              snapshot.data?.messages.length ??
                                                  0,
                                              (index) {
                                                final data = snapshot
                                                    .data?.messages[index];
                                                if (data!.role == "user") {
                                                  return WebChatUserWidget(
                                                      data: data);
                                                }
                                                return WebChatBotWidget(
                                                  data: data,
                                                  isLastMessage: (index ==
                                                          snapshot
                                                                  .data!
                                                                  .messages
                                                                  .length -
                                                              1 &&
                                                      !data.isRead),
                                                  chatBloc: _chatBloc,
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
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 65,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _chatBloc.tcQuestion,
                            validator: (val) => Validators.requiredField(val!),
                            style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                            ),
                            onEditingComplete: () =>
                                _chatBloc.add(ChatOnSendMessageEvent()),
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
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
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
