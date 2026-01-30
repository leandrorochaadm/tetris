import 'package:flutter/material.dart';
import 'piece_type.dart';
import 'position.dart';

class PieceData {
  PieceData._();

  static List<List<Position>> getRotations(PieceType type) {
    switch (type) {
      case PieceType.I:
        return [
          [Position(0, 1), Position(1, 1), Position(2, 1), Position(3, 1)],
          [Position(2, 0), Position(2, 1), Position(2, 2), Position(2, 3)],
          [Position(0, 2), Position(1, 2), Position(2, 2), Position(3, 2)],
          [Position(1, 0), Position(1, 1), Position(1, 2), Position(1, 3)],
        ];
      case PieceType.O:
        return [
          [Position(0, 0), Position(1, 0), Position(0, 1), Position(1, 1)],
          [Position(0, 0), Position(1, 0), Position(0, 1), Position(1, 1)],
          [Position(0, 0), Position(1, 0), Position(0, 1), Position(1, 1)],
          [Position(0, 0), Position(1, 0), Position(0, 1), Position(1, 1)],
        ];
      case PieceType.T:
        return [
          [Position(1, 0), Position(0, 1), Position(1, 1), Position(2, 1)],
          [Position(1, 0), Position(1, 1), Position(2, 1), Position(1, 2)],
          [Position(0, 1), Position(1, 1), Position(2, 1), Position(1, 2)],
          [Position(1, 0), Position(0, 1), Position(1, 1), Position(1, 2)],
        ];
      case PieceType.S:
        return [
          [Position(1, 0), Position(2, 0), Position(0, 1), Position(1, 1)],
          [Position(1, 0), Position(1, 1), Position(2, 1), Position(2, 2)],
          [Position(1, 1), Position(2, 1), Position(0, 2), Position(1, 2)],
          [Position(0, 0), Position(0, 1), Position(1, 1), Position(1, 2)],
        ];
      case PieceType.Z:
        return [
          [Position(0, 0), Position(1, 0), Position(1, 1), Position(2, 1)],
          [Position(2, 0), Position(1, 1), Position(2, 1), Position(1, 2)],
          [Position(0, 1), Position(1, 1), Position(1, 2), Position(2, 2)],
          [Position(1, 0), Position(0, 1), Position(1, 1), Position(0, 2)],
        ];
      case PieceType.J:
        return [
          [Position(0, 0), Position(0, 1), Position(1, 1), Position(2, 1)],
          [Position(1, 0), Position(2, 0), Position(1, 1), Position(1, 2)],
          [Position(0, 1), Position(1, 1), Position(2, 1), Position(2, 2)],
          [Position(1, 0), Position(1, 1), Position(0, 2), Position(1, 2)],
        ];
      case PieceType.L:
        return [
          [Position(2, 0), Position(0, 1), Position(1, 1), Position(2, 1)],
          [Position(1, 0), Position(1, 1), Position(1, 2), Position(2, 2)],
          [Position(0, 1), Position(1, 1), Position(2, 1), Position(0, 2)],
          [Position(0, 0), Position(1, 0), Position(1, 1), Position(1, 2)],
        ];
    }
  }

  static Color getColor(PieceType type) {
    switch (type) {
      case PieceType.I:
        return Colors.cyan;
      case PieceType.O:
        return Colors.yellow;
      case PieceType.T:
        return Colors.purple;
      case PieceType.S:
        return Colors.green;
      case PieceType.Z:
        return Colors.red;
      case PieceType.J:
        return Colors.blue;
      case PieceType.L:
        return Colors.orange;
    }
  }

  static Position getSpawnPosition(PieceType type) {
    switch (type) {
      case PieceType.I:
        return const Position(3, 0);
      case PieceType.O:
        return const Position(4, 0);
      default:
        return const Position(3, 0);
    }
  }
}
