import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/widgets/score_display.dart';

void main() {
  group('ScoreDisplay', () {
    testWidgets('displays score value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScoreDisplay(score: 1000, level: 1, lines: 5),
          ),
        ),
      );

      expect(find.text('1000'), findsOneWidget);
    });

    testWidgets('displays level value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScoreDisplay(score: 0, level: 3, lines: 0),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('displays lines value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScoreDisplay(score: 0, level: 1, lines: 15),
          ),
        ),
      );

      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('displays all labels', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScoreDisplay(score: 0, level: 1, lines: 0),
          ),
        ),
      );

      expect(find.text('SCORE'), findsOneWidget);
      expect(find.text('LEVEL'), findsOneWidget);
      expect(find.text('LINES'), findsOneWidget);
    });
  });
}
