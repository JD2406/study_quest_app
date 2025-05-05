import 'package:flutter/material.dart';
import 'package:study_quest_app/models/subject.dart';
import 'package:study_quest_app/models/teacher.dart';

class SubjectProvider with ChangeNotifier {
  final List<Subject> _subjects = [];
  final List<Teacher> _teachers = [];

  List<Subject> get subjects => _subjects;
  List<Teacher> get teachers => _teachers;

  void initialize() {
    // Datos de ejemplo
    _teachers.addAll([
      Teacher(
        id: '1',
        name: 'Prof. Pérez',
        avatarUrl: '',
        department: 'Matemáticas',
      ),
      Teacher(
        id: '2',
        name: 'Prof. García',
        avatarUrl: '',
        department: 'Física',
      ),
    ]);

    _subjects.addAll([
      Subject(
        id: '1',
        name: 'Matemáticas Avanzadas',
        teacherId: '1',
        examDate: DateTime.now().add(const Duration(days: 30)),
        color: Colors.blue,
      ),
      Subject(
        id: '2',
        name: 'Física Cuántica',
        teacherId: '2',
        examDate: DateTime.now().add(const Duration(days: 45)),
        color: Colors.green,
      ),
    ]);
    notifyListeners();
  }

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }
}
