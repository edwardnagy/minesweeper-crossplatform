import 'package:flutter/material.dart';

import '../../engine/game_engine.dart';
import '../../l10n/app_localizations.dart';

class GameHeader extends StatelessWidget {
  const GameHeader(this._engine, {super.key});

  final GameEngine _engine;

  @override
  Widget build(BuildContext context) {
    const padding = 8.0;

    return Padding(
      padding: const EdgeInsetsDirectional.all(padding),
      child: AnimatedBuilder(
        animation: _engine,
        builder: (context, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _statContainer(
                  context,
                  label: AppLocalizations.of(context).flags,
                  value: _engine.flagsRemaining.toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: padding),
                child: Tooltip(
                  message: AppLocalizations.of(context).pause,
                  child: FloatingActionButton(
                    onPressed: () {
                      // TODO: Pause the game
                    },
                    child: const Icon(Icons.pause),
                  ),
                ),
              ),
              Expanded(
                child: _statContainer(
                  context,
                  label: AppLocalizations.of(context).time,
                  value: const Duration(minutes: 10, seconds: 32).inMinutesAndSeconds,
                ),
              ),
            ],
          );
        },
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
