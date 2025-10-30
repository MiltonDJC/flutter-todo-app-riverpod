import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/notifiers/task_notifier.dart';

final taskProvider = NotifierProvider<TaskNotifier, List<Task>>(
  TaskNotifier.new,
);
