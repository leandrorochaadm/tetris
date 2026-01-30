import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/piece_type.dart';

void main() {
  group('PieceType', () {
    test('has exactly 7 piece types', () {
      expect(PieceType.values.length, 7);
    });

    test('contains all standard tetromino types', () {
      expect(PieceType.values.contains(PieceType.I), true);
      expect(PieceType.values.contains(PieceType.O), true);
      expect(PieceType.values.contains(PieceType.T), true);
      expect(PieceType.values.contains(PieceType.S), true);
      expect(PieceType.values.contains(PieceType.Z), true);
      expect(PieceType.values.contains(PieceType.J), true);
      expect(PieceType.values.contains(PieceType.L), true);
    });
  });
}
