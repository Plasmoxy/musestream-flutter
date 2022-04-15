import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class LessonDetailsScreen extends StatefulWidget {
  LessonDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LessonDetailsScreen> createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends State<LessonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    final isTeacher = true;

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
                            ),
                            Text(
                              'Teacher/Student name',
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
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date\nDate',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          child: Text('Join video call'),
                          onPressed: () {},
                        ),
                        if (isTeacher)
                          ElevatedButton(
                            child: Text('Delete'),
                            onPressed: () {},
                          ),
                      ],
                    ),
                    Text(
                        'Description description description description description description description '),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class RegusterScreen {}
