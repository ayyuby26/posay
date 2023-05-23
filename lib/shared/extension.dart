import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension StringExtension on BuildContext { 
  AppLocalizations get tr => AppLocalizations.of(this);
}
