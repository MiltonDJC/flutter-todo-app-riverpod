import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/screens/todo_home_screen.dart';

void main() {
  group('Todo Home Screen', () {
    // late Task task;

    // setUp(() {
    //   task = const Task(taskName: 'Learn Riverpod');
    // });

    testWidgets(
      'Given the application has been opened for the first time or has no saved tasks, when the user opens the application, then the main screen should be visible',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: TodoHomeScreen())),
        );
        expect(find.text('Todo App Riverpod'), findsOneWidget);
      },
    );
  });
}
