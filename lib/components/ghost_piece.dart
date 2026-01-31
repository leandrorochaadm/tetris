import 'package:flame/components.dart';
import '../models/position.dart';
import '../models/piece_type.dart';
import '../models/piece_data.dart';
import '../game/constants.dart';
import 'block.dart';

class GhostPiece extends PositionComponent {
  final double blockSize;
  final List<TetrisBlock> _blocks = [];

  GhostPiece({this.blockSize = GameConstants.defaultBlockSize});

  void updateGhost({
    required PieceType type,
    required List<Position> targetPositions,
  }) {
    for (final block in _blocks) {
      block.removeFromParent();
    }
    _blocks.clear();

    final color = PieceData.getColor(type);
    for (final pos in targetPositions) {
      final block = TetrisBlock(
        color: color,
        isGhost: true,
        blockSize: blockSize,
        position: Vector2(
          pos.x * blockSize,
          pos.y * blockSize,
        ),
      );
      _blocks.add(block);
      add(block);
    }
  }

  void clear() {
    for (final block in _blocks) {
      block.removeFromParent();
    }
    _blocks.clear();
  }
}
