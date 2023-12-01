import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitor_de_ebooks/app/core/utils/dynamic_responsive_size.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle bigText(BuildContext context, Color? color) =>
      GoogleFonts.yesevaOne(
          fontSize:
              DynamicResponsiveSize.of(context).dynamicScaleSize(size: 50),
          fontWeight: FontWeight.w700,
          color: color);

  static TextStyle titleText(BuildContext context) => GoogleFonts.inter(
      fontSize: DynamicResponsiveSize.of(context).dynamicScaleSize(size: 30),
      fontWeight: FontWeight.w700);

  static TextStyle mediumText(BuildContext context,
          [FontWeight? fontWeight, Color? color]) =>
      GoogleFonts.inter(
          fontSize:
              DynamicResponsiveSize.of(context).dynamicScaleSize(size: 18),
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color);

  static TextStyle smallText(BuildContext context) => GoogleFonts.inter(
      fontSize: DynamicResponsiveSize.of(context).dynamicScaleSize(size: 15),
      fontWeight: FontWeight.w300);

  static TextStyle customStyle(
          BuildContext context, FontWeight fontWeight, double size,
          {Color? color}) =>
      GoogleFonts.inter(
          color: color,
          fontSize:
              DynamicResponsiveSize.of(context).dynamicScaleSize(size: size),
          fontWeight: fontWeight);
}
