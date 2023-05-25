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
      // If the game is neither over nor won, then it must be in progress.
      _timeController.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameHeader(_gameController, _timeController),
      body: Padding(
        padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).padding.bottom),
        child: GameBody(_gameController),
      ),
    );
  }
}
