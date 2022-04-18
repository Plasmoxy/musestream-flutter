import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
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
            if (isTeacher)
              Container(
                padding: const EdgeInsets.only(left: 36.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      child: Text('Delete'),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      child: Text('Students of class'),
                      onPressed: () {
                        // navigation to different screen
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => DebugScreen(),
                        ));
                      },
                    ),
                  ],
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
