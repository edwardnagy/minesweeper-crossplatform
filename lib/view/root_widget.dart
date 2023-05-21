import 'package:ea_minesweeper/model/game_configuration.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'game/game_screen.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(
        configuration: GameConfiguration(horizontalTileCount: 10, verticalTileCount: 15, mineRatio: 0.15),
      ),
    );
  }
}
