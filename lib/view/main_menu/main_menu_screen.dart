import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../model/game_difficulty.dart';
import '../game/game_screen.dart';
import 'language_selector.dart';

/// Allows the user to select a game configuration (easy, medium or hard) and start a new game. Language selection is
/// also available.
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  GameDifficulty _selectedDifficulty = GameDifficulty.medium;

  void _changeDifficulty(GameDifficulty? difficulty) {
    setState(() {
      _selectedDifficulty = difficulty!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LanguageSelector(), SizedBox(width: 16)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Text(
            AppLocalizations.of(context).title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Expanded(child: SizedBox(height: 16)),
          for (final difficulty in GameDifficulty.values) ...[
            RadioListTile<GameDifficulty>(
              title: Text(difficulty.label(context)),
              value: difficulty,
              groupValue: _selectedDifficulty,
              onChanged: _changeDifficulty,
            ),
          ],
          const Spacer(flex: 3),
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

extension on GameDifficulty {
  String label(BuildContext context) {
    switch (this) {
      case GameDifficulty.easy:
        return AppLocalizations.of(context).easy;
      case GameDifficulty.medium:
        return AppLocalizations.of(context).medium;
      case GameDifficulty.hard:
        return AppLocalizations.of(context).hard;
    }
  }
}
