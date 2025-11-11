import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';
import 'package:flutter_todo_app/utils/input_validator.dart';
import 'package:flutter_todo_app/utils/is_task_repeated.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskDialogContent extends ConsumerStatefulWidget {
  const TaskDialogContent({super.key, this.taskToEdit});

  final Task? taskToEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaskDialogContentState();
}

class _TaskDialogContentState extends ConsumerState<TaskDialogContent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    String initialText = '';

    if (widget.taskToEdit != null) {
      initialText = widget.taskToEdit!.taskName;
    }

    _controller = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final taskActions = ref.read(taskProvider.notifier);

    final isEditing = widget.taskToEdit != null;

    return AlertDialog(
      title: Text(
        isEditing ? 'Editar tarea' : 'Nueva tarea',
        textAlign: TextAlign.center,
      ),
      content: TextField(
        controller: _controller,
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
              key: const Key('addTaskButton'),
              onPressed: () {
                if (inputValidator(_controller.text) == null) {
                  Fluttertoast.showToast(msg: 'Escriba el titulo de la tarea');
                } else if (isTaskRepeatead(_controller.text, tasks)) {
                  Fluttertoast.showToast(
                    msg: 'La tarea ya se encuentra en la lista',
                  );
                } else {
                  if (isEditing) {
                    taskActions.updateTask(
                      id: widget.taskToEdit!.id,
                      taskName: _controller.text,
                    );
                  } else {
                    taskActions.addTask(_controller.text);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(isEditing ? 'Guardar' : 'Agregar'),
            ),
          ],
        ),
      ],
    );
  }
}
