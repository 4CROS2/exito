import 'package:exito/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppLightTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception(
        'AppLightTheme not initialized. Call initialize() first.',
      );
    }
    return _instance!;
  }

  static void initialize(BuildContext context) {
    _instance = ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Constants.primaryLightColor,
        secondary: Constants.secondaryLightColor,
        tertiary: Constants.tertiaryLightColor,
      ),
      fontFamily: Constants.fontFamily,
      pageTransitionsTheme: Constants.pageTransition,
      appBarTheme: const AppBarTheme(
        backgroundColor: Constants.primaryLightColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: Constants.fontFamily,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.black;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Constants.primaryLightColor;
        }),
      ),
    );
  }
}
