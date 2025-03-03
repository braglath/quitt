import 'package:flutter/material.dart';
import 'package:quitt/res/colors.dart';

class AppTheme {
  // Light theme colors
  static const Color _lightPrimaryColor = AppColors.primaryColor;
  static const Color _lightAccentColor = AppColors.accentColor;
  static const Color _lightBackgroundColor = AppColors.backgroundColor;

  // Common text styles
  static const TextStyle _headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  ).copyWith(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightPrimaryColor,
      titleTextStyle: _headline1.copyWith(color: Colors.white),
    ),
    textTheme: TextTheme(
        // headline1: _headline1,
        // bodyText1: _bodyText1,
        ),
    buttonTheme: ButtonThemeData(
      buttonColor: _lightAccentColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
