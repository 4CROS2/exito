import 'package:flutter/material.dart';

/// Extension para facilitar el acceso a MediaQuery y propiedades relacionadas
/// Uso: context.mediaQuery, context.screenWidth, etc.
/// Ejemplo:
/// double width = context.screenWidth;
/// EdgeInsets padding = context.padding;
/// Size size = context.screenSize;
/// Color primaryColor = context.theme.primaryColor;
/// ColorScheme colorScheme = context.colorScheme;
/// TextTheme textTheme = context.textTheme;
extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
}
