import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/screens/task_detail_screen.dart';

void main() {
  group('taskDetailScreen', () {
    late Task taskCompleted;
    late Task taskIncompleted;

    setUp(() {
      taskCompleted = const Task(
        taskName: 'Learn Riverpod Testing',
        status: true,
      );
      taskIncompleted = const Task(
        taskName: 'Learn Riverpod Testing',
        status: false,
      );
    });

    testWidgets(
      "Given a completed task, when the TaskDetailScreen is displayed, then it should show the task name, the 'Sin descripción' text, the check icon, and the 'Edit' button.",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(home: TaskDetailScreen(task: taskCompleted)),
          ),
        );

        expect(find.text('Learn Riverpod Testing'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.byTooltip('Editar'), findsOneWidget);
      },
    );

    testWidgets(
      "Given an incompleted task, when the TaskDetailScreen is displayed, then it should show the task name, the 'Sin descripción' text, the cancel icon, and the 'Edit' button.",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(home: TaskDetailScreen(task: taskIncompleted)),
          ),
        );

        expect(find.text('Learn Riverpod Testing'), findsOneWidget);
        expect(find.text('Sin descripción'), findsOneWidget);
        expect(find.byIcon(Icons.cancel), findsOneWidget);
        expect(find.byTooltip('Editar'), findsOneWidget);
      },
    );
  });
}
