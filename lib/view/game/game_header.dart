import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.minesCount,
    required this.timeElapsed,
    required this.onPause,
  });

  final int minesCount;
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
              label: AppLocalizations.of(context).mines,
              value: minesCount.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: padding),
            child: Tooltip(
              message: AppLocalizations.of(context).pause,
              child: ElevatedButton(
                onPressed: onPause,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(Icons.pause),
                ),
              ),
            ),
          ),
          Expanded(
            child: _statContainer(
              context,
              label: AppLocalizations.of(context).time,
              value: timeElapsed.inMinutesAndSeconds,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statContainer(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 4),
          ),
        ],
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
