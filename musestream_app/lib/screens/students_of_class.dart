import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/widgets/user_card.dart';

class StudentsOfClassScreen extends HookConsumerWidget {
  final int classId;

  const StudentsOfClassScreen({Key? key, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final toDelId = useRef<int?>(null);

    final qStudents = useQuery<List<User>>(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<List<dynamic>>('/classes/$classId/students'));
        return resp.data!.map((j) => User.fromJson(j)).toList();
      }, [core]),
      activate: true,
    );

    final qDelete = useQuery<void>(
      useCallback(() async {
        await core.handle(core.dio.delete('/classes/$classId/students/${toDelId.value}'));
      }, [core]),
      onSuccess: (v) async {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students of class'),
      ),
      body: SingleChildScrollView(
        child: QueryDisplay<List<User>>(
          q: qStudents,
          val: (students) => Column(
            children: [
              QueryDisplay(q: qDelete),
              ...students!
                  .map((s) => UserCard(
                        usr: s,
                        onTap: () async {},
                        onDelete: () async {
                          toDelId.value = s.id;
                          qDelete.run();
                        },
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
