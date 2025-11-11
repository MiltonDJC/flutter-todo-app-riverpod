import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/router/router.dart';
import 'package:flutter_todo_app/screens/task_detail_screen.dart';
import 'package:flutter_todo_app/screens/todo_home_screen.dart';

void main() {
  group('Todo Home Screen', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets(
      'Given the application has been opened for the first time or has no saved tasks, when the user opens the application, then the main screen should be visible',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(home: TodoHomeScreen()),
          ),
        );

        expect(find.text('Todo App Riverpod'), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);
      },
    );
    testWidgets(
      'Given a tap on FAB to add a task, when Alert dialog it is displayed, then the user can write the task title on the Text Field to add a new task',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(home: TodoHomeScreen()),
          ),
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'learn Riverpod');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        expect(find.text('Learn Riverpod'), findsOneWidget);
      },
    );
    testWidgets(
      'Given a task added on the screen, when the Delete icon is tapped, then the task added previously is deleted successfully',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(home: TodoHomeScreen()),
          ),
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'learn Riverpod');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        expect(find.text('Learn Riverpod'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pump();

        expect(find.text('Learn Riverpod'), findsNothing);
      },
    );
    testWidgets(
      'Given a some tasks added on the screen, when the Delete icon is tapped at the last task added, then the task is deleted successfully and the first task still there',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(home: TodoHomeScreen()),
          ),
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'learn Riverpod');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'other Task');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        expect(find.text('Learn Riverpod'), findsOneWidget);
        expect(find.text('Other Task'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.delete).last);
        await tester.pump();

        expect(find.text('Learn Riverpod'), findsOneWidget);
        expect(find.text('Other Task'), findsNothing);
      },
    );
    testWidgets(
      'Given a some tasks added on the screen, when the Delete icon is tapped at the first task added, then the task is deleted successfully and the last task still there',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(home: TodoHomeScreen()),
          ),
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'learn Riverpod');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'other Task');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        expect(find.text('Learn Riverpod'), findsOneWidget);
        expect(find.text('Other Task'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.delete).last);
        await tester.pump();

        expect(find.text('Learn Riverpod'), findsOneWidget);
        expect(find.text('Other Task'), findsNothing);
      },
    );

    testWidgets(
      'Given the user is on the TodoHomeScreen, when they add a new task and tap the checkbox twice, then the task text decoration should correctly toggle from strikethrough to none.',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(home: TodoHomeScreen()),
          ),
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'learn Riverpod');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        var textWidget = tester.widget<Text>(find.text('Learn Riverpod'));

        expect(
          textWidget.style?.decoration,
          TextDecoration.lineThrough,
        ); // o lineThrough

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        textWidget = tester.widget<Text>(find.text('Learn Riverpod'));

        expect(
          textWidget.style?.decoration,
          TextDecoration.none,
        ); // o lineThrough
      },
    );
    testWidgets(
      'Given a task added on the TodoHomeScreen, when the user taps the task tile, then TaskDetailScreen is pushed and displays task details',
      (WidgetTester tester) async {
        // Renderizamos la pantalla principal
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp.router(routerConfig: router),
          ),
        );

        // Agregamos una tarea usando el FAB y el AlertDialog
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'learn Riverpod');
        await tester.tap(find.byKey(const Key('addTaskButton')));
        await tester.pumpAndSettle();

        // Verificamos que la tarea se muestra en la pantalla principal
        expect(find.text('Learn Riverpod'), findsOneWidget);

        // Tapping en el ListTile para navegar
        await tester.tap(find.byType(ListTile));
        await tester
            .pumpAndSettle(); // Esperamos que la animación de navegación termine

        // Ahora deberíamos estar en TaskDetailScreen
        expect(find.byType(TaskDetailScreen), findsOneWidget);
        expect(find.text('#0 Learn Riverpod'), findsOneWidget);
        expect(
          find.text('Sin descripción'),
          findsOneWidget,
        ); // Por defecto si no hay descripción
      },
    );
  });
}
