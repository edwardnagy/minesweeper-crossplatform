import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class EndGameDialog extends StatelessWidget {
  static void show(BuildContext context, {required bool gameWon, required VoidCallback onStartNewGame}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => EndGameDialog._(gameWon: gameWon, onStartNewGame: onStartNewGame),
    );
  }

  const EndGameDialog._({super.key, required this.gameWon, required this.onStartNewGame});

  final bool gameWon;
  final VoidCallback onStartNewGame;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        gameWon ? AppLocalizations.of(context).gameWonDialogTitle : AppLocalizations.of(context).gameLostDialogTitle,
      ),
      content: Text(
        gameWon
            ? AppLocalizations.of(context).gameWonDialogContent
            : AppLocalizations.of(context).gameLostDialogContent,
      ),
      actions: [
        TextButton(
          onPressed: onStartNewGame,
          child: Text(AppLocalizations.of(context).startNewGame),
        ),
      ],
    );
  }
}
