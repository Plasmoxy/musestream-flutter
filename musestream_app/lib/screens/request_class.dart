import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/new_class_request.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/class_card.dart';
import 'package:musestream_app/widgets/drawer.dart';

class RequestClassesScreen extends HookConsumerWidget {
  const RequestClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    final queryAll = useQuery<List<Class>>(
        useCallback(() async {
          final res = await core.handle<List<dynamic>>(core.dio.get('/classes/all'));
          return res.data!.map((j) => Class.fromJson(j)).toList();
        }, [core]),
        activate: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a class'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            QueryDisplay<List<Class>>(
              q: queryAll,
              val: (classes) => Column(
                children: classes
                        ?.map((c) => ClassCard(
                              cls: c,
                              onTap: () {
                                navigate(
                                  context,
                                  (ctx) => NewClassRequestScreen(classId: c.id),
                                );
                              },
                            ))
                        .toList() ??
                    [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
