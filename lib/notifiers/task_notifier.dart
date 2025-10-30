import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/utils/input_formatter.dart';

class TaskNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() => const [];

  void addTask(String taskName) {
    Task newTask = Task(taskName: inputFormatter(taskName));
    state = [...state, newTask];
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

  // Todo: Implementar actualización de tareas
  void updateTask(
    Task task,
    String? taskName,
    bool? status,
    String? description,
  ) {
    state = [
      for (Task item in state)
        item == task
            ? item.copyWith(
                taskName: taskName,
                status: status,
                description: description,
              )
            : item,
    ];
  }
}
