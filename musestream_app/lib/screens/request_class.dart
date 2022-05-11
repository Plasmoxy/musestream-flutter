import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/providers/allclasses.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/transactions.dart';
import 'package:musestream_app/screens/new_class_request.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/class_card.dart';
import 'package:musestream_app/widgets/drawer.dart';

class RequestClassesScreen extends HookConsumerWidget {
  const RequestClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final allClasses = ref.watch(AllClasses.provider);
    final transactions = ref.watch(Transactions.provider);

    final queryAll = useQuery(
      useCallback(() => allClasses.fetchAll(), [core]),
      activate: core.online,
      deps: [transactions.running],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a class'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            QueryDisplay(
              q: queryAll,
            ),
            Column(
              children: allClasses.items.values
                  .map((c) => ClassCard(
                        cls: c,
                        onTap: () {
                          navigate(
                            context,
                            (ctx) => NewClassRequestScreen(classId: c.id),
                          );
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
