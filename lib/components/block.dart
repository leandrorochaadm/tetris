import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/constants.dart';

class TetrisBlock extends PositionComponent {
  final Color color;
  final bool isGhost;

  TetrisBlock({
    required this.color,
    this.isGhost = false,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(GameConstants.blockSize),
        );

  @override
  void render(Canvas canvas) {
    final fillColor = isGhost
        ? color.withValues(alpha: 0.3)
        : color;
    final paint = Paint()..color = fillColor;

    final rect = Rect.fromLTWH(1, 1, size.x - 2, size.y - 2);
    canvas.drawRect(rect, paint);

    final borderPaint = Paint()
      ..color = isGhost
          ? color.withValues(alpha: 0.5)
          : Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(rect, borderPaint);

    if (!isGhost) {
      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawLine(
        const Offset(2, 2),
        Offset(size.x - 3, 2),
        highlightPaint,
      );
      canvas.drawLine(
        const Offset(2, 2),
        Offset(2, size.y - 3),
        highlightPaint,
      );
    }
  }
}
