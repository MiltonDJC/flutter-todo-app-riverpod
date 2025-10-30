import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.title,
    required this.status,
    required this.onPressed,
    required this.onChanged,
    required this.onTap,
  });

  final String title;
  final bool status;
  final VoidCallback onPressed;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          decoration: status ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(value: status, onChanged: onChanged),
          IconButton(icon: const Icon(Icons.delete), onPressed: onPressed),
        ],
      ),
      onTap: onTap,
    );
  }
}
