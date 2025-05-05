import 'package:flutter/material.dart';
import 'package:study_quest_app/models/subject.dart';

class SubjectDetailScreen extends StatelessWidget {
  const SubjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = ModalRoute.of(context)!.settings.arguments as Subject;

    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Examen: ${subject.examDate.toString()}'),
            const SizedBox(height: 20),
            const Text('Detalles de la materia:'),
            // Aquí puedes añadir más contenido
          ],
        ),
      ),
    );
  }
}
