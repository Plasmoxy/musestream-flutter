import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/widgets/lesson_card.dart';
import 'package:musestream_app/widgets/user_card.dart';

class ListOfUsersScreen extends StatefulWidget {
  ListOfUsersScreen({Key? key}) : super(key: key);

  @override
  State<ListOfUsersScreen> createState() => _ListOfUsersScreenState();
}

class _ListOfUsersScreenState extends State<ListOfUsersScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold a Appbar pre kazdru screenu
    // SingleChildScrollView -> Column
    final isTeacher = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons ofdddddddddddddd student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserCard(usr: MOCK_USER),
            UserCard(usr: MOCK_USER),
            UserCard(usr: MOCK_USER),
            UserCard(usr: MOCK_USER),
            UserCard(usr: MOCK_USER),
          ],
        ),
      ),
    );
  }
}

class RegusterScreen {}
