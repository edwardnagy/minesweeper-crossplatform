import 'package:flutter/material.dart';

import '../../engine/game_engine.dart';
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
          GameHeader(_engine),
          Expanded(
            child: GameBody(_engine),
          ),
        ],
      ),
    );
  }
}
