import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_quest_app/models/subject.dart';
import 'package:study_quest_app/providers/subject_provider.dart';
import 'package:study_quest_app/widgets/daily_quest.dart';
import 'package:study_quest_app/widgets/streak_widget.dart';
import 'package:study_quest_app/widgets/subject_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar datos si es necesario
    final subjectProvider =
        Provider.of<SubjectProvider>(context, listen: false);
    if (subjectProvider.subjects.isEmpty) {
      subjectProvider.initialize();
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Quest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => Navigator.pushNamed(context, '/calendar'),
          ),
        ],
      ),
      body: Column(
        children: [
          const StreakWidget(),
          const DailyQuest(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tus Materias',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: subjectProvider.subjects.isEmpty
                ? const Center(
                    child: Text('No hay materias agregadas'),
                  )
                : ListView.builder(
                    itemCount: subjectProvider.subjects.length,
                    itemBuilder: (ctx, index) => SubjectCard(
                      subject: subjectProvider.subjects[index],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSubjectDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSubjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Añadir Materia'),
        content: TextField(
          controller: _subjectController,
          decoration: const InputDecoration(
            labelText: 'Nombre de la materia',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_subjectController.text.isNotEmpty) {
                final newSubject = Subject(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _subjectController.text,
                  teacherId: '1', // ID por defecto
                  examDate: DateTime.now().add(const Duration(days: 30)),
                );
                Provider.of<SubjectProvider>(context, listen: false)
                    .addSubject(newSubject);
                _subjectController.clear();
                Navigator.pop(ctx);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
