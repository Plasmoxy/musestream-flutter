import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/class_details.dart';
import 'package:musestream_app/screens/lesson_details.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/my_classes.dart';
import 'package:musestream_app/screens/register.dart';
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
            ClassCard(cls: MOCK_CLASS),
            LessonCard(less: MOCK_LESSON),
          ],
        ),
      ),
    );
  }
}
