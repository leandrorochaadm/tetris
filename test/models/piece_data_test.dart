import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/piece_type.dart';
import 'package:tetris/models/piece_data.dart';

void main() {
  group('PieceData', () {
    test('each piece has 4 rotation states', () {
      for (final type in PieceType.values) {
        final rotations = PieceData.getRotations(type);
        expect(rotations.length, 4, reason: '$type should have 4 rotations');
      }
    });

    test('each rotation state has 4 blocks', () {
      for (final type in PieceType.values) {
        final rotations = PieceData.getRotations(type);
        for (int i = 0; i < rotations.length; i++) {
          expect(
            rotations[i].length,
            4,
            reason: '$type rotation $i should have 4 blocks',
          );
        }
      }
    });

    test('each piece has a unique color', () {
      final colors = PieceType.values.map(PieceData.getColor).toSet();
      expect(colors.length, 7, reason: 'Each piece should have a unique color');
    });

    test('O piece has same shape in all rotations', () {
      final rotations = PieceData.getRotations(PieceType.O);
      for (int i = 1; i < rotations.length; i++) {
        expect(
          rotations[i].toSet(),
          rotations[0].toSet(),
          reason: 'O piece should have same shape in all rotations',
        );
      }
    });

    test('I piece is 4 blocks in a line', () {
      final rotations = PieceData.getRotations(PieceType.I);
      final firstRotation = rotations[0];

      final yValues = firstRotation.map((p) => p.y).toSet();
      expect(
        yValues.length,
        1,
        reason: 'I piece first rotation should be horizontal',
      );
    });

    test('getSpawnPosition returns valid position', () {
      for (final type in PieceType.values) {
        final pos = PieceData.getSpawnPosition(type);
        expect(pos.x >= 0, true);
        expect(pos.y >= 0, true);
      }
    });
  });
}
