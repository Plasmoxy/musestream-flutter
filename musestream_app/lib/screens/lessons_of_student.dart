import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class LessonsOfStudentScreen extends StatefulWidget {
  LessonsOfStudentScreen({Key? key}) : super(key: key);

  @override
  State<LessonsOfStudentScreen> createState() => _LessonsOfStudentScreenState();
}

class _LessonsOfStudentScreenState extends State<LessonsOfStudentScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    final isTeacher = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons of student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
