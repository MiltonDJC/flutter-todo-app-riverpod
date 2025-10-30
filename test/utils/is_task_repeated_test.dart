import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/utils/is_task_repeated.dart';

void main() {
  group('isTaskRepeated', () {
    late Task task;
    late String taskName;
    late List<Task> tasks;

    setUp(() {
      task = const Task(taskName: 'Learn Riverpod');
      taskName = task.taskName;
      tasks = [task];
    });

    test(
      'Given a list of tasks, when the task to add is not inside, then returns false',
      () {
        final taskNotInList = const Task(taskName: 'Learn Flutter');
        expect(isTaskRepeatead(taskNotInList.taskName, tasks), isFalse);
      },
    );

    test(
      'Given a list of tasks, when the task to add is inside, then returns true',
      () {
        expect(isTaskRepeatead(taskName, tasks), isTrue);
      },
    );
  });
}
