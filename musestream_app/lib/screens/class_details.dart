import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class ClassDetailsStudentScreen extends StatefulWidget {
  ClassDetailsStudentScreen({Key? key}) : super(key: key);

  @override
  State<ClassDetailsStudentScreen> createState() =>
      _ClassDetailsStudentScreenState();
}

class _ClassDetailsStudentScreenState extends State<ClassDetailsStudentScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: InkWell(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(36),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Lesson name',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.left, // for example
                            ),
                            Text(
                              'Teacher name',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text('Descriptiooooon'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Upcoming lessons',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25),
            ),
            LessonCard(less: MOCK_LESSON),
            LessonCard(less: MOCK_LESSON),
            Text(
              'Past lessons',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25),
            ),
            LessonCard(less: MOCK_LESSON),
            LessonCard(less: MOCK_LESSON),
          ],
        ),
      ),
    );
  }
}

class RegusterScreen {}
