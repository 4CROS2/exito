import 'package:exito/src/core/gen/localization/app_localizations.dart';
import 'package:flutter/material.dart';

extension LocaleExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;
}
