class Task {
  final String id;
  final String title;
  final String subjectId;
  final DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.dueDate,
    this.isCompleted = false,
  });
}
