import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/widgets/task_tile.dart';

void main() {
  group('TaskTile', () {
    testWidgets(
      'Given a TaskTile, when user interacts with all touch points (checkbox, delete, and tile tap), then it renders the title and all respective callbacks (onChanged, onPressed, and onTap) are correctly triggered ',
      (WidgetTester tester) async {
        bool pressed = false;
        bool changed = false;
        bool tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TaskTile(
                title: 'Learn Riverpod',
                status: false,
                onPressed: () => pressed = true,
                onChanged: (_) => changed = true,
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        // final textWidget = tester.widget<Text>(find.text('Learn Riverpod'));

        // expect(
        //   textWidget.style?.decoration,
        //   TextDecoration.none,
        // ); // o lineThrough

        expect(find.text('Learn Riverpod'), findsOneWidget);

        await tester.tap(find.byType(Checkbox));
        await tester.tap(find.byIcon(Icons.delete));
        await tester.tap(find.byType(ListTile));

        expect(pressed, isTrue);
        expect(changed, isTrue);
        expect(tapped, isTrue);
      },
    );
  });
}

// Todo: Granularize Tests
