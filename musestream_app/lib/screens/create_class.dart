import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateClassScreen extends HookConsumerWidget {
  const CreateClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleCtrl = useTextEditingController();
    final descriptionCtrl = useTextEditingController();
    final instrumentCtrl = useTextEditingController();
    final difficultyCtrl = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create class"),
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
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: titleCtrl,
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: descriptionCtrl,
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Instrument",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: instrumentCtrl,
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Difficulty",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: difficultyCtrl,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text(
                    'Create class',
                  ),
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}
