import 'package:flutter/material.dart';

import '../../controller/game_controller.dart';
import 'tile_box.dart';

class GameBody extends StatelessWidget {
  const GameBody(this.controller, {super.key});

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    const gridSpacing = 2.0;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.tiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.configuration.horizontalTileCount,
            crossAxisSpacing: gridSpacing,
            mainAxisSpacing: gridSpacing,
          ),
          itemBuilder: (context, index) {
            return TileBox(
              tile: controller.tiles[index],
              onRevealed: () {
                controller.revealTile(index);
              },
              onFlagged: () {
                controller.toggleFlagForTile(index);
              },
            );
          },
        );
      },
    );
  }
}
