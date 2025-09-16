import 'package:flutter/material.dart';

class Constants {
  static const Color primaryLightColor = Color(0xffffe701);
  static const Color secondaryLightColor = Color(0xffffffff);
  static const Color tertiaryLightColor = Color(0xff000000);
  static const Color primaryDarkColor = Color(0xff000000);
  static const Color secondaryDarkColor = Color(0xff1c1c1c);
  static const Color tertiaryDarkColor = Color(0xffe0e0e0);
  static const String fontFamily = 'Questrial';

  static const double mainPadding = 8.0;
  static const double mainBorderRadius = 18.0;

  static const EdgeInsets mainPaddingAll = EdgeInsets.all(mainPadding);
  static const EdgeInsets contentPadding = EdgeInsets.all(mainPadding * 2);

  static PageTransitionsTheme pageTransition = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
