import 'package:arfriendv2/blocs/train/train_bloc.dart';
import 'package:arfriendv2/blocs/user/user_bloc.dart';
import 'package:arfriendv2/entities/divisi/divisi_entity.dart';
import 'package:arfriendv2/entities/role/role_entity.dart';
import 'package:arfriendv2/utils/app_color.dart';
import 'package:arfriendv2/utils/app_constanta.dart';
import 'package:arfriendv2/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_scroll/text_scroll.dart';

import '../blocs/chat/chat_bloc.dart';
import '../entities/dataset/dataset_entity.dart';
import '../pages/web/web_pagination.dart';
import 'app_text.dart';
import 'validators.dart';

class AppDialog {
  static dialogNoAction({
    required BuildContext context,
    required String title,
    String? text,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: AppText.labelW600(
              title,
              16,
              Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 125,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryDark,
                  ),
                  onPressed: () => context.pop(),
                  child: Text(
                    'Tutup',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static dialogWithActionHapus({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    String? text,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: AppText.labelW600(
              title,
              16,
              Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 125,
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        'Tutup',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: colorPrimaryDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  SizedBox(
                    width: 125,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPrimaryDark,
                      ),
                      onPressed: () {
                        context.pop();
                        onTap();
                      },
                      child: Text(
                        text ?? 'Hapus',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static dialogAddText({
    required BuildContext context,
    required TrainBloc trainBloc,
    String? text,
  }) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW700(
                "Tambah Data",
                16,
                Colors.black,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.close_rounded,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: size.width / 3,
            child: Form(
              key: trainBloc.textKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.labelW700(
                    "Target Role",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonFormField<String>(
                    items: listRole.map((RoleEntity data) {
                      return DropdownMenuItem<String>(
                        value: data.roleName,
                        child: Row(
                          children: <Widget>[
                            AppText.labelW600(
                              data.roleName,
                              14,
                              Colors.grey.shade600,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {},
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
                    "Judul",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: trainBloc.tcTitle,
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
                  const SizedBox(
                    height: 18,
                  ),
                  AppText.labelW700(
                    "Detail Info",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    maxLines: 15,
                    minLines: 3,
                    controller: trainBloc.tcDetail,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      hintText: "Jelaskan secara detail...",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 125,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            child: Text(
                              'Tutup',
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: colorPrimaryDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimaryDark,
                            ),
                            onPressed: () {
                              context.pop();
                              trainBloc.add(TrainSaveTextDataEvent());
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static dialogAddSheet({
    required BuildContext context,
    required TrainBloc trainBloc,
    String? text,
  }) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW700(
                "Tambah Data",
                16,
                Colors.black,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.close_rounded,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: size.width / 3,
            child: Form(
              key: trainBloc.textKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.labelW700(
                    "Target Role",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonFormField<String>(
                    items: listRole.map((RoleEntity data) {
                      return DropdownMenuItem<String>(
                        value: data.roleName,
                        child: Row(
                          children: <Widget>[
                            AppText.labelW600(
                              data.roleName,
                              14,
                              Colors.grey.shade600,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        trainBloc.add(TrainChooseTragetRoleEvent(val!)),
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
                    "Judul",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: trainBloc.tcTitleSheet,
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
                  const SizedBox(
                    height: 18,
                  ),
                  AppText.labelW700(
                    "Sheet ID",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: trainBloc.tcSheetID,
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
                  const SizedBox(
                    height: 18,
                  ),
                  AppText.labelW700(
                    "Sheet Name",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: trainBloc.tcSheetName,
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
                  const SizedBox(
                    height: 18,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 125,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            child: Text(
                              'Tutup',
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: colorPrimaryDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimaryDark,
                            ),
                            onPressed: () {
                              context.pop();
                              trainBloc.add(TrainFromSheetEvent());
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static dialogAddFile({
    required BuildContext context,
    required TrainBloc trainBloc,
    String? text,
  }) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => trainBloc,
          child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.labelW700(
                  "Tambah Data",
                  16,
                  Colors.black,
                ),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: size.width / 3,
              child: Form(
                key: trainBloc.textKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.labelW700(
                      "Target Role",
                      14,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    StreamBuilder<List<RoleEntity>>(
                      stream: trainBloc.apiService.streamRoles(),
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        data.add(const RoleEntity(
                            id: "add", role: 99, roleName: "TAMBAH ROLE"));
                        return DropdownButtonFormField<RoleEntity>(
                          items: List.generate(
                            snapshot.data?.length ?? 0,
                            (index) {
                              return DropdownMenuItem(
                                value: snapshot.data![index],
                                child: Row(
                                  children: <Widget>[
                                    AppText.labelW600(
                                      snapshot.data![index].roleName,
                                      14,
                                      Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          onChanged: (val) => trainBloc
                              .add(TrainChooseTragetRoleEvent(val!.roleName)),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            hintText: ".....",
                            border: const OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    AppText.labelW700(
                      "Divisi",
                      14,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    StreamBuilder<List<DivisiEntity>>(
                      stream: trainBloc.apiService.streamDivisi(),
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        data.add(const DivisiEntity(
                            id: "add", divisi: "TAMBAH DIVISI"));
                        return DropdownButtonFormField<DivisiEntity>(
                          items: List.generate(
                            data.length,
                            (index) {
                              return DropdownMenuItem(
                                value: data[index],
                                child: Row(
                                  children: <Widget>[
                                    AppText.labelW600(
                                      data[index].divisi,
                                      14,
                                      Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          onChanged: (val) => trainBloc
                              .add(TrainChooseTragetDivisiEvent(val!.id)),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            hintText: ".....",
                            border: const OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    // AppText.labelW700(
                    //   "Divisi",
                    //   14,
                    //   Colors.black,
                    // ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // BlocBuilder<TrainBloc, TrainState>(
                    //   builder: (context, state) {
                    //     return StreamBuilder<List<CategoryEntity>>(
                    //       stream: trainBloc.apiService
                    //           .streamCategory(state.targetDivisi),
                    //       builder: (context, snapshot) {
                    //         final data = snapshot.data ?? [];
                    //         data.add(const CategoryEntity(
                    //             id: "add",
                    //             title: "TAMBAH CATEGORY",
                    //             idDivisi: "add"));
                    //         return DropdownButtonFormField<CategoryEntity>(
                    //           items: List.generate(
                    //             data.length,
                    //             (index) {
                    //               return DropdownMenuItem(
                    //                 value: data[index],
                    //                 child: Row(
                    //                   children: <Widget>[
                    //                     AppText.labelW600(
                    //                       data[index].title,
                    //                       14,
                    //                       Colors.grey.shade600,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //           onChanged: (val) {},
                    //           decoration: InputDecoration(
                    //             hintStyle: GoogleFonts.poppins(),
                    //             contentPadding: const EdgeInsets.symmetric(
                    //                 vertical: 0, horizontal: 12),
                    //             hintText: ".....",
                    //             border: const OutlineInputBorder(),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    AppText.labelW700(
                      "Judul",
                      14,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: trainBloc.tcTitleFile,
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
                    const SizedBox(
                      height: 18,
                    ),
                    AppText.labelW700(
                      "File",
                      14,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () => trainBloc.add(TrainChooseFileEvent()),
                      controller: trainBloc.tcFile,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "Unggah File",
                        border: const OutlineInputBorder(),
                        suffixIcon: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.only(right: 12),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (trainBloc.tcTitleFile.text.isEmpty) {
                                AppDialog.dialogNoAction(
                                    context: context,
                                    title: "Masukan judul terlebih dahulu");
                              } else {
                                trainBloc.add(TrainChooseFileEvent());
                              }
                            },
                            child: Text(
                              "Pilih File",
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 125,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () => context.pop(),
                              child: Text(
                                'Tutup',
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: colorPrimaryDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorPrimaryDark,
                              ),
                              onPressed: () {
                                context.pop();
                                trainBloc.add(TrainSaveFileDataEvent());
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static dialogAddChat({
    required BuildContext context,
    required ChatBloc chatBloc,
    String? text,
  }) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW700(
                "Tambah Chat",
                16,
                Colors.black,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.close_rounded,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: size.width / 3,
            child: Form(
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
                        chatBloc.add(ChatOnChangeTargetEvent(val!)),
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
                    controller: chatBloc.tcTitle,
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
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 125,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            child: Text(
                              'Tutup',
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: colorPrimaryDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimaryDark,
                            ),
                            onPressed: () {
                              context.pop();
                              chatBloc.add(ChatOnCreateMessageEvent());
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static dialogLoading({
    required BuildContext context,
    String? text,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitThreeInOut(
                color: colorPrimaryDark,
                size: 25.0,
              ),
              const SizedBox(
                height: 25,
              ),
              AppText.labelW500(
                text ?? "Verifikasi \nMohon tunggu yaa..",
                16,
                Colors.grey,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  static dialogChoosDataset({
    required BuildContext context,
    required Function(List<String>) onTap,
    required List<DatasetEntity> listData,
    List<String>? listIdSelected,
  }) {
    final size = MediaQuery.of(context).size;
    List<String> listId = [];
    int token = 0;
    int pageSelected = 1;
    double page = 0;
    if (listIdSelected != null && listIdSelected.isNotEmpty) {
      for (var data in listData.where((e) => listIdSelected.contains(e.id))) {
        listId.add(data.id);
        token += data.token;
      }
    } else {
      // for (var data in listData) {
      //   listId.add(data.id);
      //   token += data.token;
      // }
    }

    listData.sort((a, b) => a.title.compareTo(b.title));
    for (int i = 0; i < listData.length; i++) {
      page = (i + 1) / 8;
      listData[i] = listData[i].copyWith(page: page.ceil());
    }
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final listFix =
              listData.where((e) => e.page == pageSelected).toList();
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppTextNormal.labelBold(
                      "Pilih Sub Topik",
                      18,
                      colorPrimaryDark,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 1.6,
                  color: Colors.grey.shade300,
                )
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // Checkbox(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(2.6),
                    //   ),
                    //   value: true,
                    //   onChanged: (val) {},
                    // ),
                    // const SizedBox(
                    //   width: 14,
                    // ),
                    // AppTextNormal.labelBold(
                    //   "Pilih Semua",
                    //   16,
                    //   token > 3700 ? Colors.red : colorPrimaryDark,
                    // ),
                    const Spacer(),
                    AppTextNormal.labelW500(
                      "Storage : ",
                      16,
                      token > 3700 ? Colors.red : colorPrimaryDark,
                    ),
                    AppTextNormal.labelBold(
                      "$token/3700",
                      16,
                      token > 3700 ? Colors.red : colorPrimaryDark,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: List.generate(listFix.length, (index) {
                        if (index.isEven) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              width: size.width / 4,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              height: 50,
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: colorPrimaryDark,
                                    value: listId.contains(listFix[index].id),
                                    onChanged: (val) {
                                      if (listId.contains(listFix[index].id)) {
                                        listId.remove(listFix[index].id);
                                        token = token - listFix[index].token;
                                      } else {
                                        listId.add(listFix[index].id);
                                        token = token + listFix[index].token;
                                      }

                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Expanded(
                                    child: TextScroll(
                                      listFix[index].title,
                                      mode: TextScrollMode.bouncing,
                                      velocity: const Velocity(
                                          pixelsPerSecond: Offset(20, 0)),
                                      delayBefore:
                                          const Duration(milliseconds: 500),
                                      numberOfReps: 25,
                                      pauseBetween: const Duration(seconds: 5),
                                      style: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.right,
                                      selectable: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    child: AppTextNormal.labelW500(
                                      listFix[index].token.toString(),
                                      12,
                                      Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ));
                        }
                        return const SizedBox();
                      }),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Column(
                      children: List.generate(listFix.length, (index) {
                        if (index.isOdd) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              width: size.width / 4,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              height: 50,
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: colorPrimaryDark,
                                    value: listId.contains(listFix[index].id),
                                    onChanged: (val) {
                                      if (listId.contains(listFix[index].id)) {
                                        listId.remove(listFix[index].id);
                                        token = token - listFix[index].token;
                                      } else {
                                        listId.add(listFix[index].id);
                                        token = token + listFix[index].token;
                                      }

                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Expanded(
                                    child: TextScroll(
                                      listFix[index].title,
                                      mode: TextScrollMode.bouncing,
                                      velocity: const Velocity(
                                          pixelsPerSecond: Offset(20, 0)),
                                      delayBefore:
                                          const Duration(milliseconds: 500),
                                      numberOfReps: 25,
                                      pauseBetween: const Duration(seconds: 5),
                                      style: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.right,
                                      selectable: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    child: AppTextNormal.labelW500(
                                      listFix[index].token.toString(),
                                      12,
                                      Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ));
                        }
                        return const SizedBox();
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                WebPagination(
                  currentPage: 1,
                  totalPage: (listData.length / 8).ceil(),
                  displayItemCount: 8,
                  onPageChanged: (page) {
                    setState(() {
                      pageSelected = page;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width / 4,
                      height: 45,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: colorPrimaryDark)),
                        onPressed: () => context.pop(),
                        child: AppTextNormal.labelBold(
                          "Batal",
                          14,
                          colorPrimaryDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    SizedBox(
                      width: size.width / 4,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimaryDark,
                        ),
                        onPressed: token > 4000
                            ? null
                            : () {
                                context.pop();
                                onTap(listId);
                              },
                        child: AppTextNormal.labelBold(
                          "Lanjutkan",
                          14,
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static dialogAddUser({
    required BuildContext context,
    required UserBloc userBloc,
  }) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelBold(
          "Tambah User",
          16,
          Colors.black,
        ),
        content: SizedBox(
          width: size.width / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.labelW700(
                "Nama User",
                14,
                Colors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: userBloc.tcNama,
                validator: (val) => Validators.requiredField(val!),
                style: GoogleFonts.poppins(
                  height: 1.4,
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    wordSpacing: 4,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  hintText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppText.labelW700(
                "Email User",
                14,
                Colors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: userBloc.tcEmail,
                validator: (val) => Validators.requiredField(val!),
                style: GoogleFonts.poppins(
                  height: 1.4,
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    wordSpacing: 4,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  hintText: "ex: johndoe@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppText.labelW700(
                "Role User",
                14,
                Colors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              DropdownButtonFormField<RoleEntity>(
                items: listRole.map((RoleEntity data) {
                  return DropdownMenuItem<RoleEntity>(
                    value: data,
                    child: Row(
                      children: <Widget>[
                        AppText.labelW600(
                          data.roleName,
                          14,
                          Colors.grey.shade600,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) => userBloc.add(UserOnChangeRoleEvent(val!)),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  hintText: ".....",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  )),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryDark,
                  ),
                  onPressed: () {
                    context.pop();
                    userBloc.add(UserRegistEvent());
                    // trainBloc.add(TrainSaveTextDataEvent());
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
            ],
          ),
        ),
      ),
    );
  }
}
