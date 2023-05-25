import 'game_configuration.dart';

enum GameDifficulty {
  easy(
    GameConfiguration(
      horizontalTileCount: 10,
      verticalTileCount: 15,
      mineRatio: 0.15,
    ),
  ),
  medium(
    GameConfiguration(
      horizontalTileCount: 15,
      verticalTileCount: 20,
      mineRatio: 0.15,
    ),
  ),
  hard(
    GameConfiguration(
      horizontalTileCount: 20,
      verticalTileCount: 25,
      mineRatio: 0.15,
    ),
  );

  const GameDifficulty(this.configuration);

  final GameConfiguration configuration;
}
