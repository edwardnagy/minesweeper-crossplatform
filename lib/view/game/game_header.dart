import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.minesLeft,
    required this.timeElapsed,
    required this.onPause,
  });

  final int minesLeft;
  final Duration timeElapsed;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    const padding = 8.0;

    return Padding(
      padding: const EdgeInsetsDirectional.all(padding),
      child: Row(
        children: [
          Expanded(
            child: _statContainer(
              context,
              icon: Icons.flag,
              value: minesLeft.toString(),
              tooltip: AppLocalizations.of(context).minesLeft(minesLeft),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: padding),
            child: IconButton(
              onPressed: onPause,
              icon: const Icon(Icons.pause),
              tooltip: AppLocalizations.of(context).pauseGame,
            ),
          ),
          Expanded(
            child: _statContainer(
              context,
              icon: Icons.timer,
              value: timeElapsed.inMinutesAndSeconds,
              tooltip: AppLocalizations.of(context).timeElapsed(timeElapsed.inMinutesAndSeconds),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statContainer(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadiusDirectional.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 6),
            Text(value),
          ],
        ),
      ),
    );
  }
}

extension on Duration {
  String get inMinutesAndSeconds {
    final minutes = inMinutes.toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
