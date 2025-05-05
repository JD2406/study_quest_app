import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String name;
  final String teacherId;
  final DateTime examDate;
  final Color color;
  int currentStreak;

  Subject({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.examDate,
    this.color = Colors.blue,
    this.currentStreak = 0,
  });
}
