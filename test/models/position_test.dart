import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/position.dart';

void main() {
  group('Position', () {
    test('creates position with x and y', () {
      const pos = Position(3, 5);
      expect(pos.x, 3);
      expect(pos.y, 5);
    });

    test('addition works correctly', () {
      const p1 = Position(1, 2);
      const p2 = Position(3, 4);
      final result = p1 + p2;
      expect(result.x, 4);
      expect(result.y, 6);
    });

    test('copyWith creates new position with updated values', () {
      const original = Position(1, 2);
      final newX = original.copyWith(x: 5);
      final newY = original.copyWith(y: 10);
      final both = original.copyWith(x: 3, y: 7);

      expect(newX.x, 5);
      expect(newX.y, 2);
      expect(newY.x, 1);
      expect(newY.y, 10);
      expect(both.x, 3);
      expect(both.y, 7);
    });

    test('equality works correctly', () {
      const p1 = Position(1, 2);
      const p2 = Position(1, 2);
      const p3 = Position(2, 1);

      expect(p1 == p2, true);
      expect(p1 == p3, false);
    });

    test('hashCode is consistent with equality', () {
      const p1 = Position(1, 2);
      const p2 = Position(1, 2);

      expect(p1.hashCode, p2.hashCode);
    });

    test('toString returns readable format', () {
      const pos = Position(3, 5);
      expect(pos.toString(), 'Position(3, 5)');
    });
  });
}
