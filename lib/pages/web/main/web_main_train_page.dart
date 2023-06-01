import 'package:arfriendv2/utils/app_text_normal.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../blocs/chatv2/chatv2_bloc.dart';
import '../../../blocs/train/train_bloc.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_constanta.dart';
import '../../../utils/app_responsive.dart';
import '../../../utils/app_text.dart';
import '../web_pagination.dart';

class WebMainTrainPage extends StatelessWidget {
  const WebMainTrainPage({
    super.key,
    required this.chatV2Bloc,
    required this.trainBloc,
  });

  final ChatV2Bloc chatV2Bloc;
  final TrainBloc trainBloc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: trainBloc.globalKey,
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
              "Train u'r bot...",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: colorPrimaryDark,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => trainBloc.add(TrainDeleteDataEvent()),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFFA90505),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Hapus",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                items: items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        onTap: () {
                          trainBloc.add(TrainOnTapSourceEvent(trainBloc, item));
                          // if (item == "Sheet") {
                          //   AppDialog.dialogAddSheet(
                          //     context: context,
                          //     trainBloc: trainBloc,
                          //   );
                          // } else if (item == "Text") {
                          //   AppDialog.dialogAddText(
                          //     context: context,
                          //     trainBloc: trainBloc,
                          //   );
                          // }
                          // // else if (item == "file") {
                          // AppDialog.dialogAddFile(
                          //     context: chatV2Bloc.globalKey.currentContext!,
                          //     trainBloc: trainBloc);
                          // // }
                        },
                        child: Text(
                          item,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                // value: selectedValue,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<TrainBloc, TrainState>(
        listener: (context, state) {
          if (state is TrainFailedLoadDataState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
                width: AppResponsive.isDesktop(context)
                    ? size.width / 4
                    : AppResponsive.isTablet(context)
                        ? size.width / 2
                        : size.width / 1.5,
                behavior: SnackBarBehavior.floating,
                content: AppTextNormal.labelW600(
                  state.errorMessage,
                  14,
                  Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }
        },
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
                color: Colors.white,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      child: Row(
                        children: [
                          Checkbox(
                            value: state.listId.length == state.datasets.length,
                            activeColor: colorPrimaryDark,
                            onChanged: (val) =>
                                trainBloc.add(TrainAddAllIdEvent()),
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
                            child: AppText.labelW700(
                              "Title",
                              14,
                              Colors.black,
                            ),
                          ),
                          Expanded(
                            child: AppText.labelW700(
                              "To",
                              14,
                              Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: AppText.labelW700(
                              "Uploaded By",
                              14,
                              Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: AppText.labelW700(
                              "Created",
                              14,
                              Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: AppText.labelW700(
                              "Updated",
                              14,
                              Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Column(
                      children: List.generate(
                          state.datasets
                                      .where((e) => e.page == state.page)
                                      .toList()
                                      .length >
                                  8
                              ? 8
                              : state.datasets
                                  .where((e) => e.page == state.page)
                                  .toList()
                                  .length, (index) {
                        final data = state.datasets
                            .where((e) => e.page == state.page)
                            .toList()[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          child: Row(
                            children: [
                              Checkbox(
                                value: state.listId.contains(data.id),
                                activeColor: colorPrimaryDark,
                                onChanged: (val) => trainBloc
                                    .add(TrainAddSingleIdEvent(data.id)),
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
                                  data.title,
                                  14,
                                  Colors.black,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW500(
                                  data.to,
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW500(
                                  data.addedBy,
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(data.createdAt))} WIB",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(data.createdAt))} WIB",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, top: 25, bottom: 25),
                      child: WebPagination(
                        currentPage: 1,
                        totalPage: (state.datasets.length / 8).ceil(),
                        displayItemCount: 8,
                        onPageChanged: (page) =>
                            trainBloc.add(TrainOnChangePageEvent(page)),
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
