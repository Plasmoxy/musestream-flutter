import 'package:flutter/material.dart';

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
          children: [],
        ),
      ),
    );
  }
}
