import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';

class MyClassesScreen extends HookConsumerWidget {
  const MyClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // v builde mam premennu
    final isTeacher = true;

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
                          crossAxisAlignment: CrossAxisAlignment.start, // for esample
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
      floatingActionButton: isTeacher
          ? FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
