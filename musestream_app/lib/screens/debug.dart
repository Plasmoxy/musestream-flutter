import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/add_student_to_class.dart';
import 'package:musestream_app/screens/class_details.dart';
import 'package:musestream_app/screens/create_class.dart';
import 'package:musestream_app/screens/lesson_details.dart';
import 'package:musestream_app/screens/lessons_of_student.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/my_classes.dart';
import 'package:musestream_app/screens/register.dart';
import 'package:musestream_app/screens/request_class.dart';
import 'package:musestream_app/screens/settings.dart';
import 'package:musestream_app/screens/students_of_class.dart';
import 'package:musestream_app/widgets/class_card.dart';
import 'package:musestream_app/widgets/drawer.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class DebugScreen extends HookConsumerWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug screen'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30), // spacing
            ElevatedButton(
              child: Text('to login screen'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => LoginScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('to register screen'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => RegisterScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('My Classes'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => MyClassesScreen(),
                ));
              },
            ),

            ElevatedButton(
              child: Text('Class details'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ClassDetailsScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Lesson details'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => LessonDetailsScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Request Class'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => RequestClassesScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Settings'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => SettingsScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Create Class'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CreateClassScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Students of class'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => StudentsOfClassCreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Add student to class'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => AddStudentToClassScreen(),
                ));
              },
            ),
            ElevatedButton(
              child: Text('Lessons of student'),
              onPressed: () {
                // navigation to different screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => LessonsOfStudentScreen(),
                ));
              },
            ),

            ClassCard(cls: MOCK_CLASS),
            LessonCard(less: MOCK_LESSON),
          ],
        ),
      ),
    );
  }
}
