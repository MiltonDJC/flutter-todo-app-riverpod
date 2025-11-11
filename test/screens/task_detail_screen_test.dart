import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';
import 'package:flutter_todo_app/screens/task_detail_screen.dart';

void main() {
  group('taskDetailScreen', () {
    late ProviderContainer container;
    late Task taskCompleted;
    late Task taskIncompleted;

    setUp(() {
      container = ProviderContainer();

      container.read(taskProvider.notifier).addTask('Learn Riverpod Testing');
      container.read(taskProvider.notifier).addTask('Learn BloC Testing');

      container.read(taskProvider.notifier).updateTask(id: 0, status: true);

      taskCompleted = container.read(taskProvider)[0];
      taskIncompleted = container.read(taskProvider)[1];
    });

    tearDown(() => container.dispose());

    testWidgets(
      "Given a completed task, when the TaskDetailScreen is displayed, then it should show the task name, the 'Sin descripción' text, the check icon, and the 'Edit' button.",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: TaskDetailScreen(taskId: taskCompleted.id),
            ),
          ),
        );

        expect(find.text('#0 Learn Riverpod Testing'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.byTooltip('Editar'), findsOneWidget);
      },
    );

    testWidgets(
      "Given an incompleted task, when the TaskDetailScreen is displayed, then it should show the task name, the 'Sin descripción' text, the cancel icon, and the 'Edit' button.",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: TaskDetailScreen(taskId: taskIncompleted.id),
            ),
          ),
        );

        expect(find.text('#1 Learn BloC Testing'), findsOneWidget);
        expect(find.text('Sin descripción'), findsOneWidget);
        expect(find.byIcon(Icons.cancel), findsOneWidget);
        expect(find.byTooltip('Editar'), findsOneWidget);
      },
    );
  });
}
