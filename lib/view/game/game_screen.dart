import 'package:flutter/material.dart';

import '../../controller/game_controller.dart';
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
  late final GameController _controller = GameController(widget.configuration);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameHeader(_controller),
      body: Padding(
        padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).padding.bottom),
        child: GameBody(_controller),
      ),
    );
  }
}
