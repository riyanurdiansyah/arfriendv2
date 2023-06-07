import 'package:animate_do/animate_do.dart';
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
import '../../../utils/app_responsive.dart';
import '../../../utils/app_text.dart';
import '../../../utils/validators.dart';
import '../web_pagination.dart';
import 'web_main_file_widget.dart';
import 'web_main_sheet_widget.dart';
import 'web_main_text_widget.dart';

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
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: colorPrimaryDark,
                fontSize: 18,
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
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
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
                                  onTap: () =>
                                      trainBloc.add(TrainGetDataSetEvent()),
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
                                  onTap: () =>
                                      trainBloc.add(TrainDeleteDataEvent()),
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
                                  onTap: () =>
                                      trainBloc.add(TrainOnAddEvent(true)),
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
                                  value: state.listId.length ==
                                      state.datasets.length,
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
                                  child: AppText.labelW500(
                                    "Judul",
                                    13,
                                    Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: AppText.labelW500(
                                    "User Akses",
                                    13,
                                    Colors.black,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: AppText.labelW500(
                                    "Diunggah oleh",
                                    13,
                                    Colors.black,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: AppText.labelW500(
                                    "Data",
                                    13,
                                    Colors.black,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: AppText.labelW500(
                                    "Tanggal Unggah",
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
                                        onChanged: (val) => trainBloc.add(
                                            TrainAddSingleIdEvent(data.id)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                          data.title,
                                          14,
                                          Colors.black,
                                        ),
                                      ),
                                      Expanded(
                                        child: AppTextNormal.labelW500(
                                          data.to.toLowerCase() != "all" &&
                                                  data.to.toLowerCase() !=
                                                      "confidential"
                                              ? "Personal"
                                              : data.to.toUpperCase(),
                                          14,
                                          Colors.black,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: AppTextNormal.labelW500(
                                          data.addedBy,
                                          14,
                                          Colors.black,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: AppTextNormal.labelW500(
                                          data.token.toString(),
                                          13,
                                          Colors.black,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: AppTextNormal.labelW500(
                                          "${DateFormat.yMMMd('id').format(DateTime.parse(data.createdAt))} WIB",
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
                ),
              ),
              if (state.isAdd)
                Expanded(
                  flex: 2,
                  child: SlideInRight(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.only(
                        right: 14,
                        top: 25,
                        bottom: 25,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: AppTextNormal.labelBold(
                                          "Tambah Data",
                                          18,
                                          colorPrimaryDark,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () => trainBloc
                                              .add(TrainOnAddEvent(false)),
                                          child: const Icon(
                                            Icons.close_rounded,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            AppTextNormal.labelW600(
                              "Pilih Source",
                              14,
                              colorPrimaryDark,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: AppTextNormal.labelW600(
                                      "File",
                                      14,
                                      colorPrimaryDark,
                                    ),
                                    activeColor: colorPrimaryDark,
                                    value: "file",
                                    groupValue: state.source,
                                    onChanged: (value) => trainBloc
                                        .add(TrainOnTapSourceEvent(value!)),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: AppTextNormal.labelW600(
                                      "Sheet",
                                      14,
                                      colorPrimaryDark,
                                    ),
                                    activeColor: colorPrimaryDark,
                                    value: "sheet",
                                    groupValue: state.source,
                                    onChanged: (value) => trainBloc
                                        .add(TrainOnTapSourceEvent(value!)),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: AppTextNormal.labelW600(
                                      "Text",
                                      14,
                                      colorPrimaryDark,
                                    ),
                                    activeColor: colorPrimaryDark,
                                    value: "text",
                                    groupValue: state.source,
                                    onChanged: (value) => trainBloc
                                        .add(TrainOnTapSourceEvent(value!)),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AppTextNormal.labelW600(
                              "User Akses",
                              14,
                              colorPrimaryDark,
                            ),
                            if (state.userAccessSelected.isNotEmpty)
                              const SizedBox(
                                height: 12,
                              ),
                            if (state.userAccessSelected.isNotEmpty)
                              Wrap(
                                runSpacing: 5,
                                spacing: 5,
                                children: List.generate(
                                  state.userAccessSelected.length,
                                  (index) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppTextNormal.labelW600(
                                            state.userAccessSelected[index],
                                            14,
                                            Colors.grey.shade400,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: 18,
                                              color: Colors.grey.shade400,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    "Pilih user",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      wordSpacing: 4,
                                    ),
                                  ),
                                  items: state.userAccess
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: AppTextNormal.labelW500(
                                            item,
                                            14,
                                            Colors.black,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) => trainBloc
                                      .add(TrainOnSelectUserAksesEvent(value!)),
                                  buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 50,
                                    padding: const EdgeInsets.only(right: 10),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 30,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AppTextNormal.labelW600(
                              "Nama Data",
                              14,
                              colorPrimaryDark,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: trainBloc.tcTitle,
                              validator: (val) =>
                                  Validators.requiredField(val!),
                              style: GoogleFonts.poppins(
                                height: 1.4,
                              ),
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  wordSpacing: 4,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 12),
                                hintText: "Isikan nama data",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppTextNormal.labelW400(
                              "*Nama file yang tersimpan akan menjadi acuan saat chat di Bot ",
                              12,
                              Colors.grey.shade500,
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            if (state.source == "sheet")
                              WebMainSheetWidget(
                                trainBloc: trainBloc,
                              ),
                            if (state.source == "file")
                              WebMainFileWidget(
                                trainBloc: trainBloc,
                              ),
                            if (state.source == "text")
                              WebMaintextWidget(trainBloc: trainBloc),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () =>
                                    trainBloc.add(TrainOnUnggahDataEvent()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorPrimaryDark,
                                ),
                                child: AppTextNormal.labelBold(
                                  "Unggah",
                                  16,
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
