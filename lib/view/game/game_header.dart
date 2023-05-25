import 'package:flutter/material.dart';

import '../../controller/game_controller.dart';
import '../../controller/time_controller.dart';
import '../../l10n/app_localizations.dart';

class GameHeader extends StatelessWidget implements PreferredSizeWidget {
  const GameHeader(this._gameController, this._timeController, {super.key});

  final GameController _gameController;
  final TimeController _timeController;

  @override
  Size get preferredSize => const Size.fromHeight(92);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _gameController,
            builder: (context, _) {
              return _statContainer(
                context,
                label: AppLocalizations.of(context).flags,
                value: _gameController.flagsRemaining.toString(),
              );
            },
          ),
        ),
        Tooltip(
          message: AppLocalizations.of(context).pause,
          child: FloatingActionButton(
            onPressed: () {
              // TODO: Pause the game
            },
            child: const Icon(Icons.pause),
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _timeController,
            builder: (context, _) {
              return _statContainer(
                context,
                label: AppLocalizations.of(context).time,
                value: _timeController.elapsed.inMinutesAndSeconds,
              );
            },
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
