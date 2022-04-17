import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/classes.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/register.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/class_card.dart';

class MyClassesScreen extends HookConsumerWidget {
  const MyClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cls = ref.watch(Classes.provider);
    final core = ref.watch(Core.provider);

    final queryMine = useQuery(useCallback(() => cls.getMine(), [cls]), activate: true);

    // v builde mam premennu
    final isTeacher = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Classes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QueryDisplay(
              q: queryMine,
              err: (e) => Text(e.toString(), style: tsErr),
            ),
            ...cls.myClasses.map((c) => ClassCard(cls: c)),
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
