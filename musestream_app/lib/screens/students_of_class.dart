import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';

import 'package:musestream_app/widgets/class_card.dart';
import 'package:musestream_app/widgets/student_card.dart';

class StudentsOfClassCreen extends HookConsumerWidget {
  const StudentsOfClassCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students of class'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StudentCard(std: MOCK_STUDENT),
            StudentCard(std: MOCK_STUDENT),
            StudentCard(std: MOCK_STUDENT),
            StudentCard(std: MOCK_STUDENT),
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
