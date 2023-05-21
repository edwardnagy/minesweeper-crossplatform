class Tile {
  final bool isMine;
  final int adjacentMineCount;
  final bool revealed;
  final bool flagged;

  const Tile({
    this.isMine = false,
    this.adjacentMineCount = 0,
    this.revealed = false,
    this.flagged = false,
  });

  Tile copyWith({
    bool? isMine,
    int? adjacentMineCount,
    bool? revealed,
    bool? flagged,
  }) {
    return Tile(
      isMine: isMine ?? this.isMine,
      adjacentMineCount: adjacentMineCount ?? this.adjacentMineCount,
      revealed: revealed ?? this.revealed,
      flagged: flagged ?? this.flagged,
    );
  }
}
