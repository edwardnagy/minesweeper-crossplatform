import 'package:flutter/material.dart';

import '../../l10n/app_localization_provider.dart';
import '../../l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppLocalizationProvider.instance,
      builder: (context, _) {
        const locales = AppLocalizations.supportedLocales;
        final currentLocale = Localizations.localeOf(context);
        final setLocale = AppLocalizationProvider.instance.setLocale;

        return Row(
          children: locales.map(
            (locale) {
              return TextButton(
                onPressed: locale != currentLocale
                    ? () {
                        setLocale(locale);
                      }
                    : null,
                child: Text(locale.languageCode.toUpperCase()),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
