import 'package:flutter/material.dart';
import 'package:study_quest_app/models/subject.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: subject.color.withOpacity(0.2),
          child: Text(
            subject.name[0],
            style: TextStyle(color: subject.color, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(subject.name),
        subtitle: Text(
          'Examen: ${subject.examDate.day}/${subject.examDate.month}',
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap:
            () => Navigator.pushNamed(
              context,
              '/subject-detail',
              arguments: subject,
            ),
      ),
    );
  }
}
