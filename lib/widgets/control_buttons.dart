import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onDown;
  final VoidCallback onRotate;
  final VoidCallback onHardDrop;

  const ControlButtons({
    super.key,
    required this.onLeft,
    required this.onRight,
    required this.onDown,
    required this.onRotate,
    required this.onHardDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(Icons.arrow_left, 'LEFT', onLeft),
          _buildButton(Icons.arrow_downward, 'DOWN', onDown),
          _buildButton(Icons.arrow_right, 'RIGHT', onRight),
          _buildButton(Icons.rotate_right, 'ROTATE', onRotate),
          _buildButton(Icons.vertical_align_bottom, 'DROP', onHardDrop),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
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
              width: 56,
              height: 56,
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
