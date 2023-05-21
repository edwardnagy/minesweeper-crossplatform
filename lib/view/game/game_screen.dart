import 'package:ea_minesweeper/engine/game_engine.dart';
import 'package:ea_minesweeper/model/game_configuration.dart';
import 'package:ea_minesweeper/view/game/game_body.dart';
import 'package:flutter/material.dart';

import 'game_header.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.configuration});

  final GameConfiguration configuration;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameEngine _engine = GameEngine(widget.configuration);

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GameHeader(
            minesCount: 10,
            timeElapsed: const Duration(minutes: 10, seconds: 32),
            onPause: () {
              // TODO: Pause the game
            },
          ),
          Expanded(
            child: GameBody(_engine),
          ),
        ],
      ),
    );
  }
}
