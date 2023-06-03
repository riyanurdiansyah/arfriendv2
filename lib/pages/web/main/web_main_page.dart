import 'package:arfriendv2/blocs/chatv2/chatv2_bloc.dart';
import 'package:arfriendv2/blocs/train/train_bloc.dart';
import 'package:arfriendv2/pages/web/main/web_main_chat_page.dart';
import 'package:arfriendv2/pages/web/main/web_main_train_page.dart';
import 'package:arfriendv2/utils/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/chat/chat_entity.dart';
import '../../../utils/app_responsive.dart';
import '../../../utils/app_text_normal.dart';

class WebMainPage extends StatefulWidget {
  const WebMainPage({super.key});

  @override
  State<WebMainPage> createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  final _chatV2Bloc = ChatV2Bloc();
  final _trainBloc = TrainBloc();

  @override
  void initState() {
    _chatV2Bloc.add(ChatV2InitialEvent());
    _trainBloc.add(TrainInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatV2Bloc>(
          create: (context) => _chatV2Bloc,
        ),
        BlocProvider<TrainBloc>(
          create: (context) => _trainBloc,
        ),
      ],
      child: Scaffold(
        key: _chatV2Bloc.globalKey,
        body: Stack(
          children: [
            Container(
              color: colorPrimaryDark,
              height: 125,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/pp.webp",
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () => _chatV2Bloc.add(
                                          ChatV2CheckTokenBeforeNewChatEvent()),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                stream: _chatV2Bloc.apiService
                                    .streamHistoryChat(
                                        FirebaseAuth.instance.currentUser!.uid),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }
                                  final data = snapshot.data ?? [];
                                  if (data.isNotEmpty) {
                                    data.sort(
                                        (a, b) => b.number.compareTo(a.number));
                                  }
                                  return SingleChildScrollView(
                                    child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                                      builder: (context, state) {
                                        return Column(
                                          children: List.generate(data.length,
                                              (index) {
                                            String text = data[index]
                                                        .title
                                                        .length >
                                                    20
                                                ? "${data[index].title.substring(0, 20)}..."
                                                : data[index].title;
                                            return OutlinedButton(
                                              onLongPress: () => _chatV2Bloc
                                                  .add(ChatV2DeleteHistoryEvent(
                                                      data[index].idChat)),
                                              style: OutlinedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor: state.idChat ==
                                                        data[index].idChat
                                                    ? colorPrimaryDark
                                                        .withOpacity(0.25)
                                                    : colorPrimary,
                                                side: BorderSide(
                                                  width: 0,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              onPressed: () => _chatV2Bloc.add(
                                                  ChatV2OnChangeRouteEvent(
                                                      data[index].idChat, "")),
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
                                                          ? colorPrimary
                                                          : colorPrimaryDark,
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Center(
                                                      child: AppTextNormal
                                                          .labelW600(
                                                        "Topik ${data[index].number}:  $text",
                                                        16,
                                                        colorPrimaryDark,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                    onPressed: () => _chatV2Bloc.add(
                                        ChatV2OnChangeRouteEvent("", "train")),
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
                                            Image.asset(
                                              "assets/images/bot.webp",
                                              width: 30,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
                                    onPressed: () => _chatV2Bloc.add(
                                        ChatV2OnChangeRouteEvent(
                                            "", "ketentuan")),
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
                                            Image.asset(
                                              "assets/images/ketentuan.webp",
                                              width: 25,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
                                    onPressed: () => _chatV2Bloc.add(
                                        ChatV2OnChangeRouteEvent(
                                            "", "panduan")),
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
                                            Image.asset(
                                              "assets/images/panduan.webp",
                                              width: 25,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
                    flex: 12,
                    child: BlocBuilder<ChatV2Bloc, ChatV2State>(
                      builder: (context, state) {
                        if (state.idChat.isNotEmpty) {
                          return WebMainChatPage(chatV2Bloc: _chatV2Bloc);
                        }
                        if (state.route == "train") {
                          return WebMainTrainPage(
                            chatV2Bloc: _chatV2Bloc,
                            trainBloc: _trainBloc,
                          );
                        }

                        if (state.route == "panduan") {
                          return Container(
                            color: Colors.red,
                          );
                        }
                        return Container(
                          color: Colors.white,
                          child: Image.asset(
                            "assets/images/bg.webp",
                            width: 350,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
