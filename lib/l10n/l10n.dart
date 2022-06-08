import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A helper extension to get the [AppLocalizations] for the current locale.
extension AppLocalizationsX on BuildContext {
  /// A helper method to get the [AppLocalizations] for the current locale.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
