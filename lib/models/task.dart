class Task {
  const Task({required this.taskName, this.status = false, this.description});

  Task copyWith({String? taskName, bool? status, String? description}) {
    return Task(
      taskName: taskName ?? this.taskName,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  final String taskName;
  final bool status;
  final String? description;
}
