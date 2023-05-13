import 'package:arfriendv2/pages/web/web_chat_widget.dart';
import 'package:arfriendv2/utils/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../entities/chat/chat_entity.dart';
import '../../utils/validators.dart';

class WebChatPage extends StatefulWidget {
  const WebChatPage({super.key});

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
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
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
                  stream: _chatBloc.apiService.streamHistoryChat(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      reverse: true,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, right: 16, left: 16, bottom: 50),
                        child: Column(
                          children: List.generate(
                              snapshot.data?.messages.length ?? 0, (index) {
                            final data = snapshot.data?.messages[index];
                            if (data!.role == "user") {
                              return WebChatUserWidget(data: data);
                            }
                            return WebChatBotWidget(
                                data: data,
                                isLastMessage: (index ==
                                        snapshot.data!.messages.length - 1 &&
                                    !data.isRead));
                          }),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 65,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  // controller: _loginBloc.tcEmail,
                  validator: (val) => Validators.requiredField(val!),
                  style: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: GoogleFonts.montserrat(
                      color: const Color(0xFFA2A4A8),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
