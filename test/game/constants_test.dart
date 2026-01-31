import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/game/constants.dart';

void main() {
  group('GameConstants', () {
    test('board dimensions are standard Tetris size', () {
      expect(GameConstants.boardWidth, 10);
      expect(GameConstants.boardHeight, 20);
    });

    test('block size is positive', () {
      expect(GameConstants.defaultBlockSize > 0, true);
    });

    test('calculateBlockSize returns appropriate size', () {
      final size = GameConstants.calculateBlockSize(300, 600);
      expect(size, 30.0);

      final widerSize = GameConstants.calculateBlockSize(400, 600);
      expect(widerSize, 30.0);

      final tallerSize = GameConstants.calculateBlockSize(300, 800);
      expect(tallerSize, 30.0);

      final smallerSize = GameConstants.calculateBlockSize(200, 400);
      expect(smallerSize, 20.0);
    });

    test('drop intervals are valid', () {
      expect(GameConstants.initialDropInterval > 0, true);
      expect(GameConstants.minDropInterval > 0, true);
      expect(
        GameConstants.initialDropInterval > GameConstants.minDropInterval,
        true,
      );
    });

    test('scoring values are positive and increase with lines', () {
      expect(GameConstants.singleLineScore > 0, true);
      expect(
        GameConstants.doubleLineScore > GameConstants.singleLineScore,
        true,
      );
      expect(
        GameConstants.tripleLineScore > GameConstants.doubleLineScore,
        true,
      );
      expect(
        GameConstants.tetrisScore > GameConstants.tripleLineScore,
        true,
      );
    });

    test('lines per level is positive', () {
      expect(GameConstants.linesPerLevel > 0, true);
    });
  });
}
