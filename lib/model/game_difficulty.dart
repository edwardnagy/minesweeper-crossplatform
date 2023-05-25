import 'game_configuration.dart';

enum GameDifficulty {
  easy(
    GameConfiguration(
      horizontalTileCount: 4,
      verticalTileCount: 4,
      mineRatio: 0.15,
    ),
  ),
  medium(
    GameConfiguration(
      horizontalTileCount: 16,
      verticalTileCount: 16,
      mineRatio: 0.15,
    ),
  ),
  hard(
    GameConfiguration(
      horizontalTileCount: 16,
      verticalTileCount: 30,
      mineRatio: 0.15,
    ),
  );

  const GameDifficulty(this.configuration);

  final GameConfiguration configuration;
}
