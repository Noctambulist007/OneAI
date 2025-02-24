import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Basic Colors
  static const Color primary = Color(0xff1BC27D);
  static const Color secondary = Color(0xFF2F867D);

  // Text Colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff333333);
  static const Color textWhite = Color(0xffffffff);

  // Background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);
  static const Color backgroundPrimary = Color(0xff191A1F);
  static const Color backgroundSecondary = Color(0xff08080D);

  // Background Container Colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = const Color(0xff36383F);

  // Button Colors
  static const Color buttonPrimary = Color.fromARGB(255, 138, 60, 55);
  static const Color buttonSecondary = Color(0xff6c7570);
  static const Color buttonDisabled = Color(0xffc4c4c4);

  // Border Colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  // Error and Validation Colors
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info =
      Color(0xff1976d2); // Color.fromARGB(255, 138, 60, 55)

  // Neutral Shades
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);

  static Color colorSurface = const Color(0xFFF9FCFF);
}
