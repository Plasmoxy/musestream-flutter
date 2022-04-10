import 'package:flutter/material.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';

class DebugScreen extends StatefulWidget {
  DebugScreen({Key? key}) : super(key: key);

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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

            // karta + padding a margin
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
                  padding: EdgeInsets.all(16),
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
                      Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Text('ahpoj'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegusterScreen {}
