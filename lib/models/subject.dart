class Subject {
  final String id;
  final String name;
  final String teacherId;
  DateTime examDate;
  List<Map<String, String>> activities; // Nueva lista para actividades

  Subject({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.examDate,
  }) : activities = [];

  get color => null; // Inicializamos la lista de actividades vacía

  // Método para agregar actividad
  void addActivity(String description, String time) {
    activities.add({'description': description, 'time': time});
  }

  // Método para obtener las actividades
  List<Map<String, String>> getActivities() {
    return activities;
  }
}
