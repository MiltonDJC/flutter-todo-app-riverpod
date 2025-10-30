import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';
import 'package:flutter_todo_app/providers/theme_provider.dart';
import 'package:flutter_todo_app/screens/task_detail_screen.dart';
import 'package:flutter_todo_app/utils/input_validator.dart';
import 'package:flutter_todo_app/utils/is_task_repeated.dart';
import 'package:flutter_todo_app/widgets/task_tile.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(task: task),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) {
              final controller = TextEditingController();
              return AlertDialog(
                title: const Text('Nueva tarea', textAlign: TextAlign.center),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Escriba el titulo de la tarea',
                  ),
                  maxLength: 500,
                  minLines: 1,
                  maxLines: 50,
                  autofocus: true,
                  textAlign: TextAlign.start,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Volver'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (inputValidator(controller.text) == null) {
                            Fluttertoast.showToast(
                              msg: 'Escriba el titulo de la tarea',
                            );
                          } else if (isTaskRepeatead(controller.text, tasks)) {
                            Fluttertoast.showToast(
                              msg: 'La tarea ya se encuentra en la lista',
                            );
                          } else {
                            taskActions.addTask(controller.text);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Agregar'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
