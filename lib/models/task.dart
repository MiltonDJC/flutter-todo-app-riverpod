class Task {
  const Task({
    required this.id,
    required this.taskName,
    this.status = false,
    this.description,
  });

  Task copyWith({String? taskName, bool? status, String? description}) {
    return Task(
      id: this.id,
      taskName: taskName ?? this.taskName,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  final int id;
  final String taskName;
  final bool status;
  final String? description;
}
