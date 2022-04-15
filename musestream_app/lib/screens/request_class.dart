import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/widgets/class_card.dart';

class RequestClassesScreen extends HookConsumerWidget {
  const RequestClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTeacher = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class requests'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassCard(cls: MOCK_CLASS),
            ClassCard(cls: MOCK_CLASS),
          ],
        ),
      ),
    );
  }
}
