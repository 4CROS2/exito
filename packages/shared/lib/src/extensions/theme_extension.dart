import 'package:flutter/material.dart';

/// Extension para facilitar el acceso a Theme y propiedades relacionadas
/// Uso: context.theme, context.colorScheme, etc.
///   Ejemplo:
///   ThemeData theme = context.theme;
///   Color primaryColor = context.primaryColor;
///  bool isDarkMode = context.isDarkMode;
/// bool isLightMode = context.isLightMode;
/// ColorScheme colorScheme = context.colorScheme;

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;

  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get tertiaryColor => colorScheme.tertiary;
}
