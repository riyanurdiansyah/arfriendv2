import 'package:arfriendv2/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../blocs/chatv2/chatv2_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_normal.dart';
import '../web_pagination.dart';

class WebMainUserPage extends StatelessWidget {
  const WebMainUserPage({
    super.key,
    required this.chatV2Bloc,
    required this.userBloc,
  });

  final ChatV2Bloc chatV2Bloc;
  final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: userBloc.globalKey,
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
          onTap: () => chatV2Bloc.add(ChatV2OnChangeRouteEvent("", "")),
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
              "Kelola User",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: colorPrimaryDark,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
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
                  "Memuat data...",
                  16,
                  Colors.grey,
                ),
              ],
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.refresh_rounded,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                            height: 16,
                            width: 2.4,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          AppTextNormal.labelW600(
                            "(${state.listId.length})",
                            16,
                            Colors.black87,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              AppDialog.dialogAddUser(
                                  context: context, userBloc: userBloc);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: colorPrimaryDark,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Tambah",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      child: Row(
                        children: [
                          Checkbox(
                            value: state.listId.length == state.users.length,
                            activeColor: colorPrimaryDark,
                            onChanged: (val) {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: Colors.red.shade300,
                                width: 0.1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            flex: 2,
                            child: AppText.labelW500(
                              "Nama",
                              13,
                              Colors.black,
                            ),
                          ),
                          Expanded(
                            child: AppText.labelW500(
                              "Email",
                              13,
                              Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: AppText.labelW500(
                              "Role",
                              13,
                              Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(
                          state.users
                                      .where((e) => e.role != 0)
                                      .toList()
                                      .length >
                                  8
                              ? 8
                              : state.users
                                  .where((e) => e.role != 0)
                                  .toList()
                                  .length, (index) {
                        final data = state.users
                            .where((e) => e.role != 0)
                            .toList()[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            color: index.isOdd
                                ? Colors.grey.shade100
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: state.listId.contains(data.id),
                                  activeColor: colorPrimaryDark,
                                  onChanged: (val) {},
                                  // onChanged: (val) => trainBloc
                                  //     .add(TrainAddSingleIdEvent(data.id)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                      color: Colors.red.shade300,
                                      width: 0.1,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AppTextNormal.labelW500(
                                    data.nama,
                                    14,
                                    Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: AppTextNormal.labelW500(
                                    data.email,
                                    14,
                                    Colors.black,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: AppTextNormal.labelW500(
                                    data.roleName,
                                    14,
                                    Colors.black,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, top: 25, bottom: 25),
                      child: WebPagination(
                        currentPage: 1,
                        totalPage: (state.users.length / 8).ceil(),
                        displayItemCount: 8,
                        onPageChanged: (page) {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
