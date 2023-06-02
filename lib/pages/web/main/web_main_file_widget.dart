import 'dart:html';

import 'package:arfriendv2/blocs/train/train_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_text_normal.dart';

class WebMainFileWidget extends StatefulWidget {
  const WebMainFileWidget({
    super.key,
    required this.trainBloc,
  });

  final TrainBloc trainBloc;

  @override
  State<WebMainFileWidget> createState() => _WebMainFileWidgetState();
}

class _WebMainFileWidgetState extends State<WebMainFileWidget> {
  late DropzoneViewController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextNormal.labelW600(
          "Unggah File",
          14,
          colorPrimaryDark,
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            if (!window.navigator.userAgent
                .toString()
                .toLowerCase()
                .contains("mac"))
              DropzoneView(
                onCreated: ((cont) {
                  controller = cont;
                }),
                onDrop: (file) async {
                  final mime = await controller.getFileMIME(file);
                  final bytes = await controller.getFileSize(file);
                  final url = await controller.createFileUrl(file);
                  print("CEK 1: ${file.name}");
                  print("CEK 2: $mime");
                  print("CEK 3: $bytes");
                  print("CEK 4: $url");
                },
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextNormal.labelW600(
                    "Tarik file ke sini",
                    16,
                    colorPrimaryDark,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppTextNormal.labelW600(
                    "atau",
                    12,
                    colorPrimaryDark,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        widget.trainBloc.add(TrainChooseFileEvent()),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      child: AppTextNormal.labelW600(
                        "Pilih File",
                        16,
                        Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          readOnly: true,
          controller: widget.trainBloc.tcFile,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "...",
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
