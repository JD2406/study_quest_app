import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_quest_app/providers/auth_provider.dart';
import 'package:study_quest_app/providers/streak_provider.dart';
import 'package:study_quest_app/providers/subject_provider.dart';
import 'package:study_quest_app/screens/calendar_screen.dart';
import 'package:study_quest_app/screens/home_screen.dart';
import 'package:study_quest_app/screens/profile_screen.dart';
import 'package:study_quest_app/screens/quiz_screen.dart';
import 'package:study_quest_app/screens/subject_detail.dart';
import 'package:study_quest_app/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => SubjectProvider(),
          builder: (context, child) {
            final provider =
                Provider.of<SubjectProvider>(context, listen: false);
            provider.initialize();
            return child!;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => StreakProvider(),
          builder: (context, child) {
            final provider =
                Provider.of<StreakProvider>(context, listen: false);
            provider.loadStreak();
            return child!;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Study Quest',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        routes: {
          '/subject-detail': (context) => const SubjectDetailScreen(),
          '/calendar': (context) => const CalendarScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/quiz': (context) => const QuizScreen(),
        },
      ),
    );
  }
}
