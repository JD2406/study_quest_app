class Task {
  final String id;
  final String title;
  final String description;
  final String time;
  final DateTime date;
  final String subjectId;
  final DateTime?
      dueDate; // Puede ser null si no se proporciona una fecha de vencimiento

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.subjectId,
    this.dueDate,
  });
}
