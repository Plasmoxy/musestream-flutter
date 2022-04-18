import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/providers/classes.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/widgets/class_card.dart';
import 'package:musestream_app/widgets/drawer.dart';

class MyClassesScreen extends HookConsumerWidget {
  const MyClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cls = ref.watch(Classes.provider);
    final core = ref.watch(Core.provider);

    final queryMine = useQuery(useCallback(() => cls.getMine(), [cls]), activate: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Classes'),
        actions: [IconButton(onPressed: queryMine.run, icon: Icon(Icons.refresh))],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QueryDisplay(
              q: queryMine,
            ),
            SizedBox(height: 16),
            ...cls.myClasses.map((c) => ClassCard(cls: c)),
          ],
        ),
      ),
      floatingActionButton: core.loginData?.user.type == 'teacher'
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
