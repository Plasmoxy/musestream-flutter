import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddStudentToClassScreen extends HookConsumerWidget {
  const AddStudentToClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtrl = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add student to class"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Student name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: nameCtrl,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text(
                    'Add to class',
                  ),
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}
