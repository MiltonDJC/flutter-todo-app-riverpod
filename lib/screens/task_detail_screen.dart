import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';
import 'package:flutter_todo_app/widgets/task_dialog_content.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Task task = ref
        .watch(taskProvider)
        .firstWhere((item) => item.id == taskId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '#${task.id} ${task.taskName}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            children: [
              const Row(children: [Text('Descripción: ')]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(task.description ?? 'Sin descripción'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    task.status == true ? (Icons.check) : (Icons.cancel),
                    color: task.status == true ? Colors.green : Colors.red,
                    size: 64,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return TaskDialogContent(taskToEdit: task);
            },
          ),
          tooltip: 'Editar',
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
