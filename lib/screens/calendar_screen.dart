import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:study_quest_app/providers/subject_provider.dart';
import 'package:study_quest_app/models/subject.dart';
import 'package:study_quest_app/models/task.dart';
import 'package:study_quest_app/providers/task_provider.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<Subject>> _events;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _events = {};
    _loadEvents();
  }

  void _loadEvents() {
    final subjectProvider =
        Provider.of<SubjectProvider>(context, listen: false);
    final subjects = subjectProvider.subjects;

    for (var subject in subjects) {
      final examDate = subject.examDate;
      if (_events[examDate] == null) {
        _events[examDate] = [];
      }
      _events[examDate]!.add(subject);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Exámenes'),
      ),
      body: Column(
        children: [
          // TableCalendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Add Activity Button
          ElevatedButton(
            onPressed: () => _showAddActivityDialog(context),
            child: const Text('Añadir Actividad'),
          ),
          const SizedBox(height: 20),
          // Show Activities for Selected Date
          Consumer<TaskProvider>(
            builder: (context, taskProvider, _) {
              final tasks = taskProvider.tasks
                  .where((task) => isSameDay(task.date, _selectedDay))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text('${task.description} - ${task.time}'),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Añadir Actividad'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _activityController,
                decoration: const InputDecoration(labelText: 'Actividad'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Hora'),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_activityController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  // Save the activity
                  final task = Task(
                    id: DateTime.now().toString(), // Generando ID único
                    title: _activityController.text,
                    description: 'Actividad para ${_selectedDay.toLocal()}',
                    time: _timeController.text,
                    date: _selectedDay,
                    subjectId: '', // Este valor debe ser asignado adecuadamente
                    dueDate:
                        null, // Puedes asignar una fecha de vencimiento si es necesario
                  );
                  Provider.of<TaskProvider>(context, listen: false)
                      .addTask(task);
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
