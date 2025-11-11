import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/utils/input_formatter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'task_provider.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  int _taskId = 0;

  void _incrementId() => _taskId++;

  @override
  List<Task> build() => const [];

  void addTask(String taskName) {
    state = [...state, Task(id: _taskId, taskName: inputFormatter(taskName))];
    _incrementId();
  }

  void removeTask(Task task) {
    state = state.where((item) => item != task).toList();
  }

  void toggleStatus(Task task) {
    state = [
      for (Task item in state)
        item == task ? item.copyWith(status: !item.status) : item,
    ];
  }

  void updateTask({
    required int id,
    String? taskName,
    bool? status,
    String? description,
  }) {
    state = [
      for (Task item in state)
        item.id == id
            ? item.copyWith(
                taskName: taskName,
                status: status,
                description: description,
              )
            : item,
    ];
  }
}
