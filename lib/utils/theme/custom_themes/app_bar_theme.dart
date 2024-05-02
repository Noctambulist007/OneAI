import 'package:flutter/material.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  // Light Theme
  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, size: 24.0),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 24.0),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.black));

  // Dark Theme
  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, size: 24.0),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24.0),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white));
}
