import 'package:flutter/material.dart';

class Constants {
  static const Color primaryLightColor = Color(0xffffe701);
  static const Color secondaryLightColor = Color(0xffffffff);
  static const Color tertiaryLightColor = Color(0xFFF3E5E5);
  static const Color primaryDarkColor = Color(0xff000000);
  static const Color secondaryDarkColor = Color(0xff1c1c1c);
  static const Color tertiaryDarkColor = Color.fromRGBO(224, 224, 224, 1);
  static const String fontFamily = 'Questrial';

  static const Duration animationDuration = Duration(milliseconds: 450);

  static const double mainPaddingValue = 8.0;
  static const double mainBorderRadiusValue = 18.0;

  static const BorderRadius mainBorderRadius = BorderRadius.all(
    Radius.circular(mainBorderRadiusValue),
  );
  static const BorderRadius innerBorderRadius = BorderRadius.all(
    Radius.circular(mainBorderRadiusValue - mainPaddingValue),
  );

  static const EdgeInsets mainPaddingAll = EdgeInsets.all(mainPaddingValue);
  static const EdgeInsets contentPadding = EdgeInsets.all(mainPaddingValue * 2);

  static PageTransitionsTheme pageTransition = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
