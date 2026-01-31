import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onDown;
  final VoidCallback onRotate;
  final VoidCallback onHardDrop;
  final bool compact;

  const ControlButtons({
    super.key,
    required this.onLeft,
    required this.onRight,
    required this.onDown,
    required this.onRotate,
    required this.onHardDrop,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final buttonSize = compact
            ? (maxWidth / 6).clamp(40.0, 52.0)
            : (maxWidth / 6).clamp(48.0, 56.0);
        final iconSize = buttonSize * 0.5;
        final fontSize = compact ? 8.0 : 10.0;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: compact ? 8 : 16,
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(Icons.arrow_left, 'LEFT', onLeft, buttonSize, iconSize, fontSize),
              _buildButton(Icons.arrow_downward, 'DOWN', onDown, buttonSize, iconSize, fontSize),
              _buildButton(Icons.arrow_right, 'RIGHT', onRight, buttonSize, iconSize, fontSize),
              _buildButton(Icons.rotate_right, 'ROTATE', onRotate, buttonSize, iconSize, fontSize),
              _buildButton(Icons.vertical_align_bottom, 'DROP', onHardDrop, buttonSize, iconSize, fontSize),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
    double size,
    double iconSize,
    double fontSize,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: const Color(0xFF2A2A4E),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: iconSize),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: fontSize,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
