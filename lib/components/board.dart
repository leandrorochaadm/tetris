import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/constants.dart';
import '../models/position.dart';
import 'block.dart';

class Board extends PositionComponent {
  final List<List<Color?>> _grid = List.generate(
    GameConstants.boardHeight,
    (_) => List.filled(GameConstants.boardWidth, null),
  );

  final List<TetrisBlock> _lockedBlocks = [];

  @override
  Future<void> onLoad() async {
    size = Vector2(
      GameConstants.boardWidth * GameConstants.blockSize,
      GameConstants.boardHeight * GameConstants.blockSize,
    );
  }

  @override
  void render(Canvas canvas) {
    final bgPaint = Paint()..color = GameConstants.boardBackground;
    canvas.drawRect(size.toRect(), bgPaint);

    final gridPaint = Paint()
      ..color = GameConstants.gridLineColor
      ..strokeWidth = 0.5;

    for (int x = 0; x <= GameConstants.boardWidth; x++) {
      canvas.drawLine(
        Offset(x * GameConstants.blockSize, 0),
        Offset(x * GameConstants.blockSize, size.y),
        gridPaint,
      );
    }
    for (int y = 0; y <= GameConstants.boardHeight; y++) {
      canvas.drawLine(
        Offset(0, y * GameConstants.blockSize),
        Offset(size.x, y * GameConstants.blockSize),
        gridPaint,
      );
    }
  }

  bool isValidPosition(List<Position> positions) {
    for (final pos in positions) {
      if (pos.x < 0 || pos.x >= GameConstants.boardWidth) return false;
      if (pos.y >= GameConstants.boardHeight) return false;
      if (pos.y >= 0 && _grid[pos.y][pos.x] != null) return false;
    }
    return true;
  }

  void lockPiece(List<Position> positions, Color color) {
    for (final pos in positions) {
      if (pos.y >= 0 && pos.y < GameConstants.boardHeight) {
        _grid[pos.y][pos.x] = color;
      }
    }
    _updateLockedBlocks();
  }

  int clearLines() {
    int linesCleared = 0;

    for (int y = GameConstants.boardHeight - 1; y >= 0; y--) {
      if (_grid[y].every((cell) => cell != null)) {
        _grid.removeAt(y);
        _grid.insert(0, List.filled(GameConstants.boardWidth, null));
        linesCleared++;
        y++;
      }
    }

    if (linesCleared > 0) {
      _updateLockedBlocks();
    }

    return linesCleared;
  }

  bool isGameOver() {
    return _grid[0].any((cell) => cell != null) ||
        _grid[1].any((cell) => cell != null);
  }

  void reset() {
    for (int y = 0; y < GameConstants.boardHeight; y++) {
      for (int x = 0; x < GameConstants.boardWidth; x++) {
        _grid[y][x] = null;
      }
    }
    _updateLockedBlocks();
  }

  void _updateLockedBlocks() {
    for (final block in _lockedBlocks) {
      block.removeFromParent();
    }
    _lockedBlocks.clear();

    for (int y = 0; y < GameConstants.boardHeight; y++) {
      for (int x = 0; x < GameConstants.boardWidth; x++) {
        if (_grid[y][x] != null) {
          final block = TetrisBlock(
            color: _grid[y][x]!,
            position: Vector2(
              x * GameConstants.blockSize,
              y * GameConstants.blockSize,
            ),
          );
          _lockedBlocks.add(block);
          add(block);
        }
      }
    }
  }
}
