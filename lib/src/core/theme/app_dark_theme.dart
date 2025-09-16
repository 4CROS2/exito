import 'package:exito/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppDarkTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception('AppDarkTheme not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  static void initialize(BuildContext context) {
    _instance = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Constants.primaryDarkColor,
        secondary: Constants.secondaryDarkColor,
        tertiary: Constants.tertiaryDarkColor,
      ),
      fontFamily: Constants.fontFamily,
      pageTransitionsTheme: Constants.pageTransition,
      appBarTheme: const AppBarTheme(
        backgroundColor: Constants.primaryDarkColor,
        foregroundColor: Constants.primaryLightColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Constants.primaryLightColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: Constants.fontFamily,
        ),
      ),
    );
  }
}
