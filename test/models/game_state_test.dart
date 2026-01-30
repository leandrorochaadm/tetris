import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/game_state.dart';

void main() {
  group('GameState', () {
    test('has exactly 4 states', () {
      expect(GameState.values.length, 4);
    });

    test('contains all required states', () {
      expect(GameState.values.contains(GameState.ready), true);
      expect(GameState.values.contains(GameState.playing), true);
      expect(GameState.values.contains(GameState.paused), true);
      expect(GameState.values.contains(GameState.gameOver), true);
    });
  });
}
