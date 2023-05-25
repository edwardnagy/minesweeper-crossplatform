import 'package:flutter/material.dart';

import '../../controller/game_controller.dart';
import '../../controller/time_controller.dart';
import '../../model/game_configuration.dart';
import '../game_dialog/end_game_dialog.dart';
import '../game_dialog/pause_dialog.dart';
import '../main_menu/main_menu_screen.dart';
import 'game_body.dart';
import 'game_header.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.configuration});

  final GameConfiguration configuration;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController _gameController = GameController(widget.configuration);
  late final TimeController _timeController = TimeController(updateFrequency: const Duration(seconds: 1));

  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _gameController.addListener(_gameStateListener);
  }

  @override
  void dispose() {
    _gameController.removeListener(_gameStateListener);
    _gameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _gameStateListener() {
    if (_gameController.isGameLost) {
      _timeController.stop();
      EndGameDialog.show(context, gameWon: false, onStartNewGame: _quit);
    } else if (_gameController.isGameWon) {
      _timeController.stop();
      EndGameDialog.show(context, gameWon: true, onStartNewGame: _quit);
    } else {
      // If the game is not over or won, then it must be in progress.
      _timeController.start();
    }
  }

  void _pause() {
    PauseDialog.show(context, onQuit: _quit).then(
      // resume the game when the dialog is closed
      (_) => _resume(),
    );
    _timeController.stop();
    setState(() {
      _isPaused = true;
    });
  }

  void _quit() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainMenuScreen(),
      ),
      (_) => false,
    );
  }

  void _resume() {
    _timeController.start();
    setState(() {
      _isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([_gameController, _timeController]),
              builder: (context, _) {
                return GameHeader(
                  flagsRemaining: _gameController.flagsRemaining,
                  elapsedTime: _timeController.elapsed,
                  paused: _isPaused,
                  onPause: _pause,
                  onResume: _resume,
                );
              },
            ),
            Expanded(
              child: Opacity(
                opacity: _isPaused ? 0.5 : 1.0,
                child: IgnorePointer(
                  ignoring: _isPaused,
                  child: GameBody(_gameController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
