import 'package:ea_minesweeper/view/game/game_body.dart';
import 'package:flutter/material.dart';

import 'game_header.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GameHeader(
            minesLeft: 10,
            timeElapsed: const Duration(minutes: 10, seconds: 32),
            onPause: () {
              // TODO: Pause the game
            },
          ),
          const Expanded(child: GameBody()),
        ],
      ),
    );
  }
}
