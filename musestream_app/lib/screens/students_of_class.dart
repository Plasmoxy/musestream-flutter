import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/students.dart';
import 'package:musestream_app/providers/transactions.dart';
import 'package:musestream_app/screens/lessons_of_student.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/netstatus.dart';
import 'package:musestream_app/widgets/user_card.dart';

class StudentsOfClassScreen extends HookConsumerWidget {
  final int classId;

  const StudentsOfClassScreen({Key? key, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final transactions = ref.watch(Transactions.provider);
    final students = ref.watch(Students.provider);
    final toDelId = useRef<int?>(null);

    final qStudents = useQuery(
      useCallback(() => students.fetchClassStudents(classId), [core]),
      activate: core.online,
      deps: [transactions.running],
    );

    final qDelete = useQuery<void>(
      useCallback(() => transactions.make(() => core.handle(core.dio.delete('/classes/$classId/students/${toDelId.value}'))), [core]),
      onSuccess: (v) async {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students of class'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NetStatus(),
            QueryDisplay(q: qStudents),
            QueryDisplay(q: qDelete),
            ...students
                .getByClass(classId)
                .map((s) => UserCard(
                      usr: s,
                      onTap: () async {
                        await navigate(context, (ctx) => StudentLessonsScreen(studentId: s.id, classId: classId));
                        qStudents.run();
                      },
                      onDelete: () async {
                        toDelId.value = s.id;
                        qDelete.run();
                      },
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
