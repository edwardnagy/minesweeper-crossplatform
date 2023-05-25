import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../model/game_configuration.dart';
import '../game/game_screen.dart';

/// Allows the user to select a game configuration (easy, medium or hard) and start a new game. Language selection is
/// also available.
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  _GameDifficulty _selectedDifficulty = _GameDifficulty.medium;

  void _changeDifficulty(_GameDifficulty? difficulty) {
    setState(() {
      _selectedDifficulty = difficulty!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 3),
          Text(
            AppLocalizations.of(context).title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Expanded(child: SizedBox(height: 16)),
          for (final difficulty in _GameDifficulty.values) ...[
            RadioListTile<_GameDifficulty>(
              title: Text(difficulty.label(context)),
              value: difficulty,
              groupValue: _selectedDifficulty,
              onChanged: _changeDifficulty,
            ),
          ],
          const Spacer(flex: 4),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      configuration: _selectedDifficulty.configuration,
                    ),
                  ),
                );
              },
              label: Text(AppLocalizations.of(context).startGame),
              icon: const Icon(Icons.play_arrow),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

enum _GameDifficulty {
  easy(
    GameConfiguration(
      horizontalTileCount: 10,
      verticalTileCount: 15,
      mineRatio: 0.15,
    ),
  ),
  medium(
    GameConfiguration(
      horizontalTileCount: 15,
      verticalTileCount: 20,
      mineRatio: 0.15,
    ),
  ),
  hard(
    GameConfiguration(
      horizontalTileCount: 20,
      verticalTileCount: 25,
      mineRatio: 0.15,
    ),
  );

  const _GameDifficulty(this.configuration);

  final GameConfiguration configuration;

  String label(BuildContext context) {
    switch (this) {
      case _GameDifficulty.easy:
        return AppLocalizations.of(context).easy;
      case _GameDifficulty.medium:
        return AppLocalizations.of(context).medium;
      case _GameDifficulty.hard:
        return AppLocalizations.of(context).hard;
    }
  }
}
