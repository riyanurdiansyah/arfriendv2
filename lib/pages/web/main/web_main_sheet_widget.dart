import 'package:arfriendv2/blocs/train/train_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_text_normal.dart';
import '../../../utils/validators.dart';

class WebMainSheetWidget extends StatelessWidget {
  const WebMainSheetWidget({
    super.key,
    required this.trainBloc,
  });

  final TrainBloc trainBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextNormal.labelW600(
          "Isikan link Google Sheet",
          14,
          colorPrimaryDark,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: trainBloc.tcSheetLink,
          keyboardType: TextInputType.multiline,
          validator: (val) => Validators.requiredField(val!),
          style: GoogleFonts.poppins(
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: "co: https://docs.google.com/spreadsheets/d/",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
