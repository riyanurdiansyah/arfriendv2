import 'package:arfriendv2/utils/app_color.dart';
import 'package:arfriendv2/utils/app_text.dart';
import 'package:arfriendv2/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../utils/app_constanta.dart';
import '../../utils/validators.dart';

class HistoryChatPage extends StatefulWidget {
  const HistoryChatPage({super.key});

  @override
  State<HistoryChatPage> createState() => _HistoryChatPageState();
}

class _HistoryChatPageState extends State<HistoryChatPage> {
  final _chatBloc = ChatBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _chatBloc.add(ChatInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor:
            colorPrimaryDark.withOpacity(0.5), // ubah warna status bar disini
      ),
      child: BlocProvider<ChatBloc>(
        create: (context) => _chatBloc,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: Scaffold(
              appBar: AppBar(
                backgroundColor: colorPrimaryDark,
                leading: IconButton(
                  onPressed: () => _scaffoldKey.currentState!.closeEndDrawer(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
                title: AppText.labelW600(
                  "Chat",
                  18,
                  Colors.white,
                ),
                iconTheme: const IconThemeData(),
                elevation: 0,
              ),
              body: Form(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.labelW700(
                        "Target",
                        14,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownButtonFormField<String>(
                        items: listDivisi.map((String data) {
                          return DropdownMenuItem<String>(
                            value: data,
                            child: Row(
                              children: <Widget>[
                                AppText.labelW600(
                                  data,
                                  14,
                                  Colors.grey.shade600,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            _chatBloc.add(ChatOnChangeTargetEvent(val!)),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                          hintText: ".....",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      AppText.labelW700(
                        "Judul Chat",
                        14,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _chatBloc.tcTitle,
                        textInputAction: TextInputAction.done,
                        validator: (val) => Validators.requiredField(val!),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                          hintText: "....",
                          border: const OutlineInputBorder(),
                        ),
                        // onChanged: (val) =>
                        //     _blastBloc.add(BlastOnChangeTextFieldEvent("hp", val)),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryDark,
                  ),
                  onPressed: () {
                    context.pop();
                    _chatBloc.add(ChatOnCreateMessageEvent());
                  },
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: colorPrimaryDark,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Image.asset(
                "assets/images/logo.webp",
                width: 125,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                // SizedBox(
                //   width: double.infinity,
                //   height: size.height,
                //   child: Image.asset(
                //     "assets/images/bg.webp",
                //     fit: BoxFit.cover,
                //   ),
                // ),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.listHistory.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.labelW400(
                              "Tidak ada history",
                              16,
                              Colors.grey,
                            ),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: List.generate(
                        state.listHistory.length,
                        (index) => ListTile(
                          onTap: () {
                            _chatBloc.add(ChatOnTapHistoryIdEvent(
                                state.listHistory[index].idChat));
                            context.pushNamed(RouteName.chatapp,
                                extra: _chatBloc,
                                queryParameters: {
                                  "id": state.listHistory[index].idChat
                                });
                          },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
