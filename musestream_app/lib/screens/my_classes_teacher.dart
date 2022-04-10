import 'package:flutter/material.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';

class MyClassesTeacherScreen extends StatefulWidget {
  MyClassesTeacherScreen({Key? key}) : super(key: key);

  @override
  State<MyClassesTeacherScreen> createState() => _MyClassesTeacherScreenState();
}

class _MyClassesTeacherScreenState extends State<MyClassesTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Classes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
