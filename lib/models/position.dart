class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  Position operator +(Position other) => Position(x + other.x, y + other.y);

  Position copyWith({int? x, int? y}) => Position(x ?? this.x, y ?? this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Position($x, $y)';
}
