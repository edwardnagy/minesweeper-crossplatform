import 'package:flutter/material.dart';

import '../../controller/game_controller.dart';
import '../../controller/time_controller.dart';
import '../../model/game_configuration.dart';
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
    if (_gameController.isGameOver) {
      _timeController.stop();
    } else if (_gameController.isGameWon) {
      _timeController.stop();
    } else {
      // If the game is not over or won, then it must be in progress.
      _timeController.start();
    }
  }

  void _pause() {
    _timeController.stop();
    setState(() {
      _isPaused = true;
    });
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
