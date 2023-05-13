import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:arfriendv2/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../entities/dataset/message_entity.dart';

class WebChatBotWidget extends StatelessWidget {
  const WebChatBotWidget({
    super.key,
    required this.data,
    required this.isLastMessage,
  });

  final MessageEntity data;
  final bool isLastMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: isLastMessage
                      ? AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              data.content,
                              textStyle: GoogleFonts.sourceSansPro(
                                fontSize: 14,
                                color: const Color(0xFF1F2228),
                              ),
                              speed: const Duration(milliseconds: 20),
                            ),
                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: false,
                          stopPauseOnTap: false,
                        )
                      : AppText.labelW500(
                          data.content,
                          14,
                          const Color(0xFF1F2228),
                          maxLines: 100,
                          height: 1.6,
                        ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AppText.labelW600(
                    DateFormat.jm('id').format(DateTime.parse(data.date)),
                    12,
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class WebChatUserWidget extends StatelessWidget {
  const WebChatUserWidget({
    super.key,
    required this.data,
  });

  final MessageEntity data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: AppText.labelW500(
                    data.content,
                    14,
                    const Color(0xFF1F2228),
                    maxLines: 100,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AppText.labelW600(
                    DateFormat.jm('id').format(DateTime.parse(data.date)),
                    12,
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
