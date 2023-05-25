import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.flagsRemaining,
    required this.elapsedTime,
    required this.paused,
    required this.onPause,
    required this.onResume,
  });

  final int flagsRemaining;
  final Duration elapsedTime;
  final bool paused;
  final VoidCallback onPause;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _statContainer(
            context,
            label: AppLocalizations.of(context).flags,
            value: flagsRemaining.toString(),
          ),
        ),
        if (paused) ...[
          Tooltip(
            message: AppLocalizations.of(context).resume,
            child: FloatingActionButton(
              onPressed: onResume,
              child: const Icon(Icons.play_arrow_rounded),
            ),
          ),
        ] else ...[
          Tooltip(
            message: AppLocalizations.of(context).pause,
            child: FloatingActionButton(
              onPressed: onPause,
              child: const Icon(Icons.pause_rounded),
            ),
          ),
        ],
        Expanded(
          child: _statContainer(
            context,
            label: AppLocalizations.of(context).time,
            value: elapsedTime.inMinutesAndSeconds,
          ),
        ),
      ],
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
            textAlign: TextAlign.center,
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
