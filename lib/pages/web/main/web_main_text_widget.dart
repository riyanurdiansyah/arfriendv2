import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../blocs/train/train_bloc.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_normal.dart';
import '../../../utils/validators.dart';

class WebMaintextWidget extends StatelessWidget {
  const WebMaintextWidget({
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
          "Rincian Detail Data",
          14,
          colorPrimaryDark,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          maxLines: 15,
          minLines: 3,
          controller: trainBloc.tcDetail,
          keyboardType: TextInputType.multiline,
          validator: (val) => Validators.requiredField(val!),
          style: GoogleFonts.poppins(
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: "Isikan detail data",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
