import 'package:flutter/material.dart';

import '../../controller/game_controller.dart';
import 'tile_box.dart';

class GameBody extends StatefulWidget {
  const GameBody(this.controller, {super.key});

  final GameController controller;

  @override
  State<GameBody> createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    const gridSpacing = 2.0;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scrollbar(
          controller: _scrollController,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const ClampingScrollPhysics(),
            controller: _scrollController,
            itemCount: widget.controller.tiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.controller.configuration.horizontalTileCount,
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
            ),
            itemBuilder: (context, index) {
              return TileBox(
                tile: widget.controller.tiles[index],
                onRevealed: () {
                  widget.controller.revealTile(index);
                },
                onFlagged: () {
                  widget.controller.toggleFlagForTile(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}
