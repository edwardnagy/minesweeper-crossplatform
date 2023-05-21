import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../model/game_configuration.dart';
import '../model/tile.dart';

class GameEngine with ChangeNotifier {
  final GameConfiguration configuration;

  GameEngine(this.configuration) {
    _generateTiles();
    _placeMines();
    _computeAdjacentMineCounts();
  }

  late List<Tile> _tiles;

  List<Tile> get tiles => UnmodifiableListView(_tiles);

  void _generateTiles() {
    _tiles = List.generate(
      configuration.tileCount,
      (index) => const Tile(),
    );
  }

  void _placeMines() {
    final mineLocations = <int>{};
    final random = Random();
    while (mineLocations.length < configuration.mineCount) {
      mineLocations.add(random.nextInt(configuration.tileCount));
    }
    for (final mineLocation in mineLocations) {
      _tiles[mineLocation] = _tiles[mineLocation].copyWith(isMine: true);
    }
  }

  void _computeAdjacentMineCounts() {
    for (var index = 0; index < _tiles.length; index++) {
      var adjacentMineCount = 0;
      final adjacentTileIndices = _getAdjacentTileIndices(index);
      for (final adjacentTileIndex in adjacentTileIndices) {
        if (_tiles[adjacentTileIndex].isMine) {
          adjacentMineCount++;
        }
      }
      _tiles[index] = _tiles[index].copyWith(adjacentMineCount: adjacentMineCount);
    }
  }

  List<int> _getAdjacentTileIndices(int index) {
    final isTopRow = index < configuration.horizontalTileCount;
    final isBottomRow = index >= configuration.tileCount - configuration.horizontalTileCount;
    final isLeftColumn = index % configuration.horizontalTileCount == 0;
    final isRightColumn = (index + 1) % configuration.horizontalTileCount == 0;

    final adjacentTileIndices = [
      if (!isTopRow && !isLeftColumn) index - configuration.horizontalTileCount - 1, // Top left
      if (!isTopRow) index - configuration.horizontalTileCount, // Top
      if (!isTopRow && !isRightColumn) index - configuration.horizontalTileCount + 1, // Top right
      if (!isLeftColumn) index - 1, // Left
      if (!isRightColumn) index + 1, // Right
      if (!isBottomRow && !isLeftColumn) index + configuration.horizontalTileCount - 1, // Bottom left
      if (!isBottomRow) index + configuration.horizontalTileCount, // Bottom
      if (!isBottomRow && !isRightColumn) index + configuration.horizontalTileCount + 1, // Bottom right
    ];
    return adjacentTileIndices;
  }

  void revealTile(int index) {
    _tiles[index] = _tiles[index].copyWith(revealed: true);
    notifyListeners();
  }
}
