import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../model/tile.dart';

class TileBox extends StatelessWidget {
  const TileBox({
    super.key,
    required this.tile,
    required this.onRevealed,
    required this.onFlagged,
  });

  final Tile tile;
  final VoidCallback onRevealed;
  final VoidCallback onFlagged;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    final shape = RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2));

    return Stack(
      children: [
        Material(
          color: color.withOpacity(0.25),
          shape: shape,
          child: Center(
            child: tile.isMine
                ? _mine(context)
                : tile.adjacentMineCount > 0
                    ? _adjacentMineCountText(context)
                    : null,
          ),
        ),
        if (!tile.revealed) ...[
          Positioned.fill(
            child: Listener(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2)),
                  backgroundColor: color,
                  padding: EdgeInsetsDirectional.zero,
                ),
                onPressed: onRevealed,
                onLongPress: onFlagged,
                child: Center(child: tile.flagged ? _flag(context) : null),
              ),
              onPointerDown: (event) async {
                // Check if right mouse button clicked
                if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
                  onFlagged();
                }
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _mine(BuildContext context) {
    return const Icon(Icons.dangerous, color: Colors.red);
  }

  Widget _adjacentMineCountText(BuildContext context) {
    final adjacentMineCount = tile.adjacentMineCount;
    final Color color;
    switch (adjacentMineCount) {
      case 1:
        color = Colors.blue;
        break;
      case 2:
        color = Colors.green;
        break;
      default:
        color = Colors.red;
        break;
    }

    return Text(
      adjacentMineCount.toString(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _flag(BuildContext context) {
    return const Icon(Icons.flag, color: Colors.red);
  }
}
