class GameConfiguration {
  final int horizontalTileCount;
  final int verticalTileCount;
  final double mineRatio;

  const GameConfiguration({
    required this.horizontalTileCount,
    required this.verticalTileCount,
    required this.mineRatio,
  });

  int get tileCount => horizontalTileCount * verticalTileCount;

  int get mineCount => (tileCount * mineRatio).round();

  int get flagCount => mineCount;
}
