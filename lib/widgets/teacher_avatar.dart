import 'package:flutter/material.dart';
import 'package:study_quest_app/models/teacher.dart';

class TeacherAvatar extends StatelessWidget {
  final Teacher teacher;

  const TeacherAvatar({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(teacher.avatarUrl),
      radius: 25,
    );
  }
}
