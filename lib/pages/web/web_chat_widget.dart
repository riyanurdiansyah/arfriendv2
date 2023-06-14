import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:arfriendv2/utils/app_color.dart';
import 'package:arfriendv2/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../entities/dataset/message_entity.dart';
import '../../utils/app_responsive.dart';

class WebChatBotWidget extends StatelessWidget {
  const WebChatBotWidget({
    super.key,
    required this.data,
    required this.isLastMessage,
    required this.onFinish,
  });

  final MessageEntity data;
  final bool isLastMessage;
  final VoidCallback onFinish;

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
                SlideInLeft(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorPrimaryDark,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: isLastMessage
                        ? AnimatedTextKit(
                            onFinished: () => onFinish(),
                            animatedTexts: [
                              TypewriterAnimatedText(
                                data.content,
                                textStyle: GoogleFonts.sourceSansPro(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 2,
                                ),
                                speed: const Duration(milliseconds: 20),
                              ),
                            ],
                            totalRepeatCount: 1,
                            pause: const Duration(milliseconds: 1000),
                            displayFullTextOnTap: false,
                            stopPauseOnTap: false,
                          )
                        : AppText.labelW400(
                            data.content,
                            16,
                            Colors.white,
                            maxLines: 100,
                            height: 2,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AppText.labelW500(
                    DateFormat.jm('id').format(DateTime.parse(data.date)),
                    12,
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (!AppResponsive.isMobile(context))
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
          if (!AppResponsive.isMobile(context))
            const Expanded(
              child: SizedBox(),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SlideInRight(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: AppText.labelW400(
                      data.content,
                      16,
                      colorPrimaryDark,
                      maxLines: 100,
                      height: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AppText.labelW500(
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
