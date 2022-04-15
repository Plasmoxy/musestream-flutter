import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';
import 'package:musestream_app/widgets/class_card.dart';

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
            ClassCard(cls: MOCK_CLASS),
            ClassCard(cls: MOCK_CLASS),
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
