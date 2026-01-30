import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/screens/main_menu_screen.dart';

void main() {
  group('MainMenuScreen', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: MainMenuScreen()),
      );

      expect(find.text('TETRIS'), findsOneWidget);
    });

    testWidgets('displays start game button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: MainMenuScreen()),
      );

      expect(find.text('START GAME'), findsOneWidget);
    });

    testWidgets('displays rankings button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: MainMenuScreen()),
      );

      expect(find.text('RANKINGS'), findsOneWidget);
    });
  });
}
