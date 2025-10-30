String? inputValidator(String newTaskTitle) =>
    newTaskTitle.trim().isNotEmpty ? newTaskTitle : null;
