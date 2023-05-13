import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static labelNormal(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW400(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    FontStyle? fontStyle,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static labelW500(String title, double fontSize, Color colors,
      {String? familiy,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines,
      FontStyle? fontStyle,
      double? height,
      bool? softWarp}) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      minLines: 1,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: colors,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW600(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    FontStyle? fontStyle,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static labelW700(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      minLines: 1,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW800(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      minLines: 1,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
        color: colors,
      ),
    );
  }

  static labelW900(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      minLines: 1,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w900,
        fontSize: fontSize,
        color: colors,
      ),
    );
  }

  static labelBold(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return SelectableText(
      title,
      textAlign: textAlign ?? TextAlign.start,
      minLines: 1,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }
}
