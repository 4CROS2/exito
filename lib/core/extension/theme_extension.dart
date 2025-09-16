import 'package:exito/core/theme/theme.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;
  void initializeTheme() {
    AppLightTheme.initialize(this);
    AppDarkTheme.initialize(this);
  }
}
