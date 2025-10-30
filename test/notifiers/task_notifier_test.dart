import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';

void main() {
  group('TaskNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'Given an instance of TaskNotifier, when this one is built, then the state is empty',
      () {
        expect(container.read(taskProvider), isEmpty);
      },
    );

    test(
      'Given a list of tasks, when a task is added to the list, then the list updates with the new task',
      () {
        final notifier = container.read(taskProvider.notifier);
        notifier.addTask('learn riverpod test');

        final tasks = container.read(taskProvider);
        expect(tasks.length, 1);
        expect(tasks.first.taskName, 'Learn riverpod test');
        expect(tasks.first.status, isFalse);
      },
    );

    test(
      'Given a list of tasks, when it is removed to the list, then te list contains the new task',
      () {
        final notifier = container.read(taskProvider.notifier);

        notifier.addTask('learn riverpod test');

        var tasks = container.read(taskProvider);
        expect(tasks.length, 1);
        final task = tasks.first;
        expect(task.taskName, 'Learn riverpod test');

        notifier.removeTask(task);

        tasks = container.read(taskProvider);
        expect(tasks.length, 0);
      },
    );

    test(
      'Given a task that is not completed, when toggleStatus function is called twice, then the task status change to completed and then to incompleted',
      () {
        final notifier = container.read(taskProvider.notifier);
        notifier.addTask('learn riverpod test');

        var task = container.read(taskProvider).first;
        expect(task.status, isFalse);

        notifier.toggleStatus(task);

        task = container.read(taskProvider).first;
        expect(task.status, isTrue);

        notifier.toggleStatus(task);

        task = container.read(taskProvider).first;
        expect(task.status, isFalse);
      },
    );

    // Todo: Implementar test para actualización de tarea
    // test('test name', () {});
  });
}
