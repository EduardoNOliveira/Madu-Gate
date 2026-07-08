import 'package:flutter/material.dart';

class AppPalette {
  static const Color brandPrimary = Color(0xFF44469B);
  static const Color brandSecondary = Color(0xFF1AA6DE);
  static const Color darkBg = Color(0xFF050B1D);
  static const Color darkCard = Color(0xFF0B132A);
  static const Color lightBg = Color(0xFFF3F6FB);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppPalette.lightBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.brandSecondary,
      primary: AppPalette.brandSecondary,
      secondary: AppPalette.brandPrimary,
      surface: Colors.white,
    ),
    fontFamily: 'Roboto',
  );
}
