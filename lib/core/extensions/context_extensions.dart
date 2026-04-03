import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension ContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
