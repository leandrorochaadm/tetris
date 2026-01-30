import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/piece_type.dart';
import '../models/piece_data.dart';
import '../game/constants.dart';
import 'block.dart';

class NextPieceDisplay extends PositionComponent {
  final List<TetrisBlock> _blocks = [];
  static const double _previewBlockSize = 20.0;

  NextPieceDisplay({required Vector2 position})
      : super(
          position: position,
          size: Vector2(100, 100),
        );

  @override
  void render(Canvas canvas) {
    final bgPaint = Paint()..color = GameConstants.boardBackground;
    final borderPaint = Paint()
      ..color = GameConstants.gridLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(rect, bgPaint);
    canvas.drawRect(rect, borderPaint);

    const textStyle = TextStyle(
      color: Colors.white70,
      fontSize: 12,
    );
    final textSpan = TextSpan(text: 'NEXT', style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset((size.x - textPainter.width) / 2, 5));
  }

  void showPiece(PieceType type) {
    for (final block in _blocks) {
      block.removeFromParent();
    }
    _blocks.clear();

    final rotations = PieceData.getRotations(type);
    final color = PieceData.getColor(type);

    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (final pos in rotations[0]) {
      if (pos.x < minX) minX = pos.x.toDouble();
      if (pos.x > maxX) maxX = pos.x.toDouble();
      if (pos.y < minY) minY = pos.y.toDouble();
      if (pos.y > maxY) maxY = pos.y.toDouble();
    }

    final pieceWidth = (maxX - minX + 1) * _previewBlockSize;
    final pieceHeight = (maxY - minY + 1) * _previewBlockSize;
    final offsetX = (size.x - pieceWidth) / 2 - minX * _previewBlockSize;
    final offsetY = (size.y - pieceHeight) / 2 - minY * _previewBlockSize + 10;

    for (final pos in rotations[0]) {
      final block = TetrisBlock(
        color: color,
        position: Vector2(
          offsetX + pos.x * _previewBlockSize,
          offsetY + pos.y * _previewBlockSize,
        ),
      )..size = Vector2.all(_previewBlockSize);
      _blocks.add(block);
      add(block);
    }
  }
}
