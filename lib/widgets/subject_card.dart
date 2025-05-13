import 'package:flutter/material.dart';
import 'package:study_quest_app/models/subject.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: subject.color.withOpacity(0.2),
          child: Text(
            subject.name[0], // Letra inicial de la materia
            style: TextStyle(
              color: subject.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          subject.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostrar fecha de examen
            Text(
              'Examen: ${subject.examDate.day}/${subject.examDate.month}/${subject.examDate.year}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            // Mostrar las actividades asociadas a esta materia
            if (subject.activities.isNotEmpty)
              ...subject.activities.map((activity) => Text(
                    'Actividad: ${activity.description} - ${activity.time}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ))
            else
              const Text(
                'No hay actividades asignadas.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: () {
          // Al tocar, se navega hacia los detalles de la materia
          Navigator.pushNamed(
            context,
            '/subject-detail',
            arguments: subject,
          );
        },
      ),
    );
  }
}

extension on Map<String, String> {
  get description => null;

  get time => null;
}
