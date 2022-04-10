import 'package:flutter/material.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';

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
            Card(
              margin: EdgeInsets.all(16),
              // REFACTOR MENU = Ctrl Shift R
              child: InkWell(
                onTap: () {
                  // navigation to different screen
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => LoginScreen(),
                  ));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(36),
                  // co je vnutri tej karty ?
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // for esample
                          children: [
                            Text(
                              'Lesson name',
                              style: TextStyle(fontSize: 30), // for example
                            ),
                            Text('Teacher name'),
                          ],
                        ),
                      ),
                      ClipOval(
                        child: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                          width: 60,
                          height: 60,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegusterScreen {}
