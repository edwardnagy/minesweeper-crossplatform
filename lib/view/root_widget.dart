import 'package:flutter/material.dart';

import '../l10n/app_localization_provider.dart';
import '../l10n/app_localizations.dart';
import 'main_menu/main_menu_screen.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppLocalizationProvider.instance,
      builder: (context, _) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: AppLocalizationProvider.instance.locale,
          onGenerateTitle: (context) => AppLocalizations.of(context).title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainMenuScreen(),
        );
      },
    );
  }
}
