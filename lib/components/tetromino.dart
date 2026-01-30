import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/constants.dart';
import '../models/piece_type.dart';
import '../models/piece_data.dart';
import '../models/position.dart';
import 'block.dart';

class Tetromino extends PositionComponent {
  final PieceType type;
  int _rotationState = 0;
  Position _boardPosition;
  final List<TetrisBlock> _blocks = [];

  Tetromino({
    required this.type,
    required Position startPosition,
  }) : _boardPosition = startPosition;

  @override
  Future<void> onLoad() async {
    _updateBlocks();
  }

  List<Position> getBlockPositions() {
    final rotations = PieceData.getRotations(type);
    return rotations[_rotationState]
        .map((p) => Position(_boardPosition.x + p.x, _boardPosition.y + p.y))
        .toList();
  }

  void moveLeft() {
    _boardPosition = Position(_boardPosition.x - 1, _boardPosition.y);
    _updateBlocks();
  }

  void moveRight() {
    _boardPosition = Position(_boardPosition.x + 1, _boardPosition.y);
    _updateBlocks();
  }

  void moveDown() {
    _boardPosition = Position(_boardPosition.x, _boardPosition.y + 1);
    _updateBlocks();
  }

  void rotate() {
    _rotationState = (_rotationState + 1) % 4;
    _updateBlocks();
  }

  void undoRotate() {
    _rotationState = (_rotationState - 1 + 4) % 4;
    _updateBlocks();
  }

  void undoMove(Position previousPosition) {
    _boardPosition = previousPosition;
    _updateBlocks();
  }

  Position get boardPosition => _boardPosition;
  int get rotationState => _rotationState;

  Color get color => PieceData.getColor(type);

  void _updateBlocks() {
    for (final block in _blocks) {
      block.removeFromParent();
    }
    _blocks.clear();

    final color = PieceData.getColor(type);
    for (final pos in getBlockPositions()) {
      final block = TetrisBlock(
        color: color,
        position: Vector2(
          pos.x * GameConstants.blockSize,
          pos.y * GameConstants.blockSize,
        ),
      );
      _blocks.add(block);
      add(block);
    }
  }
}
