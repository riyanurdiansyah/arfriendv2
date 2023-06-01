import 'package:arfriendv2/blocs/chatv2/chatv2_bloc.dart';
import 'package:arfriendv2/utils/app_color.dart';
import 'package:arfriendv2/utils/route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../entities/chat/chat_entity.dart';
import '../../utils/app_responsive.dart';
import '../../utils/app_text_normal.dart';
import '../../utils/validators.dart';
import 'web_animation_cursor.dart';
import 'web_chat_widget.dart';

class WebMainPage extends StatefulWidget {
  const WebMainPage({super.key});

  @override
  State<WebMainPage> createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  final _chatV2Bloc = ChatV2Bloc();

  @override
  void initState() {
    _chatV2Bloc.add(ChatV2InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<ChatV2Bloc>(
      create: (context) => _chatV2Bloc,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: const Color(0xff004B7B),
          automaticallyImplyLeading: false,
          elevation: 0,
          leadingWidth: 0,
          title: Image.asset(
            "assets/images/logo.webp",
            width: 200,
          ),
          centerTitle: false,
        ),
        body: Row(
          children: [
            if (!AppResponsive.isMobile(context))
              Expanded(
                flex: 3,
                child: Container(
                  color: colorPrimary,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "images/pp.jpeg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextNormal.labelW600(
                                        "Dummy",
                                        16,
                                        Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      AppTextNormal.labelW400(
                                        "CEO",
                                        12.5,
                                        colorPrimaryDark,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.settings_rounded,
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () =>
                                    _chatV2Bloc.add(ChatV2CreateNewChatEvent()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: colorPrimaryDark,
                                      width: 20,
                                      height: 20,
                                      child: const Icon(
                                        Icons.add_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    AppTextNormal.labelW600(
                                      "Topik Baru",
                                      14,
                                      colorPrimaryDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: StreamBuilder<List<ChatEntity>>(
                          stream: _chatV2Bloc.apiService.streamHistoryChat(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox();
                            }
                            final data = snapshot.data ?? [];
                            if (data.isNotEmpty) {
                              data.sort((a, b) => b.number.compareTo(a.number));
                            }
                            return SingleChildScrollView(
                              child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                                builder: (context, state) {
                                  return Column(
                                    children:
                                        List.generate(data.length, (index) {
                                      String text = data[index].title.length >
                                              20
                                          ? "${data[index].title.substring(0, 20)}..."
                                          : data[index].title;
                                      return OutlinedButton(
                                        onLongPress: () => _chatV2Bloc.add(
                                            ChatV2DeleteHistoryEvent(
                                                data[index].idChat)),
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          backgroundColor:
                                              state.idChat == data[index].idChat
                                                  ? colorPrimaryDark
                                                      .withOpacity(0.25)
                                                  : colorPrimary,
                                          side: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        onPressed: () => _chatV2Bloc.add(
                                            ChatV2OnTapHistoryEvent(
                                                data[index].idChat)),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 5,
                                                color: state.idChat !=
                                                        data[index].idChat
                                                    ? Colors.white
                                                    : colorPrimaryDark,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Center(
                                                child: AppTextNormal.labelW600(
                                                  "Topik ${data[index].number}:  $text",
                                                  16,
                                                  colorPrimaryDark,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const Spacer(),
                                              const Center(
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 18,
                                                  color: colorPrimaryDark,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: colorPrimary,
                                side: const BorderSide(
                                  width: 0,
                                  color: colorPrimary,
                                ),
                              ),
                              onPressed: () =>
                                  launchUrlString("#/${RouteName.train}"),
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      const Icon(
                                        Icons.book_rounded,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: AppTextNormal.labelW600(
                                          "Latih Bot Disini...",
                                          16,
                                          colorPrimaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: colorPrimary,
                                side: const BorderSide(
                                  width: 0,
                                  color: colorPrimary,
                                ),
                              ),
                              onPressed: () {},
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      const Icon(
                                        Icons.warning_rounded,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: AppTextNormal.labelW600(
                                          "Ketentuan",
                                          16,
                                          colorPrimaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: colorPrimary,
                                side: const BorderSide(
                                  width: 0,
                                  color: colorPrimary,
                                ),
                              ),
                              onPressed: () {},
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      const Icon(
                                        Icons.book_rounded,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: AppTextNormal.labelW600(
                                          "Panduan",
                                          16,
                                          colorPrimaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              flex: 10,
              child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                builder: (context, state) {
                  if (state.idChat.isEmpty) {
                    return Center(
                      child: Image.asset(
                        "assets/images/bg.webp",
                        width: 350,
                      ),
                    );
                  }
                  return Scaffold(
                    key: _chatV2Bloc.globalKey,
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
                        onTap: () =>
                            _chatV2Bloc.add(ChatV2OnTapHistoryEvent("")),
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
                        StreamBuilder(
                          builder: (context, snapshot) {
                            return StreamBuilder<ChatEntity>(
                              stream: _chatV2Bloc.apiService
                                  .streamChat(state.idChat),
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
                                                      onFinish: () =>
                                                          _chatV2Bloc.add(
                                                              ChatV2UpdateIsReadEvent(
                                                                  snapshot.data!
                                                                      .messages,
                                                                  index)));
                                                },
                                              ),
                                            ),
                                            state.isTyping
                                                ? const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                    bottomNavigationBar: SizedBox(
                      child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              if (!state.isOnVoice)
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: TextFormField(
                                      readOnly: state.isTyping,
                                      controller: _chatV2Bloc.tcQuestion,
                                      validator: (val) =>
                                          Validators.requiredField(val!),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey.shade600,
                                      ),
                                      onEditingComplete: () => _chatV2Bloc
                                          .add(ChatV2CheckMessagesInDBEvent()),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
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
      ),
    );
  }
}
