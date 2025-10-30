import 'package:flutter_todo_app/models/task.dart';

bool isTaskRepeatead(String taskName, List<Task> tasks) {
  for (Task item in tasks) {
    if (item.taskName.toLowerCase() == taskName.toLowerCase()) {
      return true;
    }
  }
  return false;
}
