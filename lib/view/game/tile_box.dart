import 'package:flutter/material.dart';

import '../../model/tile.dart';

class TileBox extends StatelessWidget {
  const TileBox({
    super.key,
    required this.tile,
    required this.onTap,
  });

  final Tile tile;
  final VoidCallback onTap;

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
                ? const Icon(Icons.dangerous, color: Colors.red)
                : Text(
                    tile.adjacentMineCount != 0 ? tile.adjacentMineCount.toString() : '',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: _getTextColor(tile.adjacentMineCount),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
          ),
        ),
        if (!tile.revealed) ...[
          Positioned.fill(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2)),
                backgroundColor: color,
              ),
              onPressed: onTap,
              child: const SizedBox(),
            ),
          ),
        ],
      ],
    );
  }

  Color _getTextColor(int adjacentMineCount) {
    switch (adjacentMineCount) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      default:
        return Colors.red;
    }
  }
}
