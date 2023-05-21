import 'package:ea_minesweeper/engine/game_engine.dart';
import 'package:flutter/material.dart';

import 'tile_box.dart';

class GameBody extends StatelessWidget {
  const GameBody(this.engine, {super.key});

  final GameEngine engine;

  @override
  Widget build(BuildContext context) {
    const gridSpacing = 2.0;

    return AnimatedBuilder(
      animation: engine,
      builder: (context, _) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: engine.tiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: engine.configuration.horizontalTileCount,
            crossAxisSpacing: gridSpacing,
            mainAxisSpacing: gridSpacing,
          ),
          itemBuilder: (context, index) {
            return TileBox(
              tile: engine.tiles[index],
              onTap: () {
                engine.revealTile(index);
              },
            );
          },
        );
      },
    );
  }
}
