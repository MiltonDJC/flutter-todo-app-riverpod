import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';
import 'package:flutter_todo_app/providers/theme_provider.dart';
import 'package:flutter_todo_app/widgets/task_dialog_content.dart';
import 'package:flutter_todo_app/widgets/task_tile.dart';
import 'package:go_router/go_router.dart';

class TodoHomeScreen extends ConsumerWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final taskActions = ref.read(taskProvider.notifier);
    final theme = ref.watch(themeProvider);
    final themeActions = ref.read(themeProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App Riverpod'),
          actions: [
            Switch(value: theme, onChanged: (_) => themeActions.toggleTheme()),
          ],
        ),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            final task = tasks[index];
            return TaskTile(
              title: task.taskName,
              status: task.status,
              onPressed: () => taskActions.removeTask(task),
              onChanged: (_) => taskActions.toggleStatus(task),
              onTap: () => context.pushNamed(
                'detail',
                pathParameters: {'id': '${task.id}'},
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return const TaskDialogContent();
            },
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
