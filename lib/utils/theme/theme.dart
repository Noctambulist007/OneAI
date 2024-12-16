import 'package:flutter/material.dart';

import 'custom_themes/app_bar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class CustomTheme {
  CustomTheme._();

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: Colors.brown,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: CustomCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: Colors.brown,
    brightness: Brightness.dark,
    textTheme: CustomTextTheme.darkTheme,
    scaffoldBackgroundColor: Colors.black,
    chipTheme: CustomChipTheme.darkChipTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: CustomCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}
