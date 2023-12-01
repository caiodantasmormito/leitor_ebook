import 'package:flutter/material.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData defaultTheme() => ThemeData(
    useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenOne),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      );
}
