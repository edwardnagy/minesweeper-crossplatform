class Tile {
  final bool isMine;
  final int adjacentMineCount;
  final bool revealed;

  const Tile({
    this.isMine = false,
    this.adjacentMineCount = 0,
    this.revealed = false,
  });

  Tile copyWith({
    bool? isMine,
    int? adjacentMineCount,
    bool? revealed,
  }) {
    return Tile(
      isMine: isMine ?? this.isMine,
      adjacentMineCount: adjacentMineCount ?? this.adjacentMineCount,
      revealed: revealed ?? this.revealed,
    );
  }
}
