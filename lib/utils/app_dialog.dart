import 'package:arfriendv2/blocs/train/train_bloc.dart';
import 'package:arfriendv2/entities/divisi/divisi_entity.dart';
import 'package:arfriendv2/entities/role/role_entity.dart';
import 'package:arfriendv2/utils/app_color.dart';
import 'package:arfriendv2/utils/app_constanta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/chat/chat_bloc.dart';
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
                        'Hapus',
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
                    items: listRole.map((String data) {
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
                    keyboardType: TextInputType.number,
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
                    items: listRole.map((String data) {
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
                            id: "add", role: "TAMBAH ROLE", roleId: -1));
                        return DropdownButtonFormField<RoleEntity>(
                          items: List.generate(
                            snapshot.data?.length ?? 0,
                            (index) {
                              return DropdownMenuItem(
                                value: snapshot.data![index],
                                child: Row(
                                  children: <Widget>[
                                    AppText.labelW600(
                                      snapshot.data![index].role,
                                      14,
                                      Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          onChanged: (val) => trainBloc
                              .add(TrainChooseTragetRoleEvent(val!.role)),
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
                    keyboardType: TextInputType.number,
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
}
