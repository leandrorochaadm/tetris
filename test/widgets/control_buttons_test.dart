import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/widgets/control_buttons.dart';

void main() {
  group('ControlButtons', () {
    testWidgets('calls onLeft when left button is tapped', (tester) async {
      bool called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              onLeft: () => called = true,
              onRight: () {},
              onDown: () {},
              onRotate: () {},
              onHardDrop: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_left));
      expect(called, true);
    });

    testWidgets('calls onRight when right button is tapped', (tester) async {
      bool called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              onLeft: () {},
              onRight: () => called = true,
              onDown: () {},
              onRotate: () {},
              onHardDrop: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_right));
      expect(called, true);
    });

    testWidgets('calls onDown when down button is tapped', (tester) async {
      bool called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              onLeft: () {},
              onRight: () {},
              onDown: () => called = true,
              onRotate: () {},
              onHardDrop: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_downward));
      expect(called, true);
    });

    testWidgets('calls onRotate when rotate button is tapped', (tester) async {
      bool called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              onLeft: () {},
              onRight: () {},
              onDown: () {},
              onRotate: () => called = true,
              onHardDrop: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.rotate_right));
      expect(called, true);
    });

    testWidgets('calls onHardDrop when drop button is tapped', (tester) async {
      bool called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              onLeft: () {},
              onRight: () {},
              onDown: () {},
              onRotate: () {},
              onHardDrop: () => called = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.vertical_align_bottom));
      expect(called, true);
    });
  });
}
