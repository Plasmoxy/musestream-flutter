import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/edit_class.dart';
import 'package:musestream_app/screens/lesson_details.dart';
import 'package:musestream_app/screens/students_of_class.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class ClassDetailsScreen extends HookConsumerWidget {
  final int classId;

  const ClassDetailsScreen({Key? key, required this.classId}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    final qClass = useQuery(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<dynamic>('/classes/$classId'));
        return Class.fromJson(resp.data);
      }, [core]),
      activate: true,
    );

    final qLessons = useQuery(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<List<dynamic>>('/classes/$classId/lessons'));
        return resp.data?.map((j) => Lesson.fromJson(j)).toList();
      }, [core]),
      activate: qClass.value != null,
    );

    final qDelete = useQuery<void>(
      useCallback(() async {
        await core.handle(core.dio.delete('/classes/$classId'));
      }, [core]),
      onSuccess: (v) async {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Details'),
        actions: [
          IconButton(
              onPressed: () {
                qLessons.run();
                qClass.run();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: QueryDisplay<Class>(
          q: qClass,
          val: (cls) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // class rendering
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(36),
                  child: Row(
                    children: [
                      Icon(Icons.school, size: 32),
                      SizedBox(width: 32),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cls!.title,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.left, // for example
                            ),
                            Text(
                              'with ' + (cls.teacher?.fullName ?? ''),
                              style: TextStyle(fontSize: 16),
                            ),
                            Text('• Instrument: ' + cls.instrument),
                            Text('• Description: ' + cls.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // actions
                if (core.user?.type == 'teacher')
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          await navigate(context, (ctx) => EditClassScreen(toEdit: cls));
                          qClass.run();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          if (await showConfirmDialog(context, 'Delete class?', 'Are you sure?')) {
                            qDelete.run();
                          }
                        },
                      ),
                      ElevatedButton(
                        child: Text('Students of class'),
                        onPressed: () async {
                          await navigate(
                              context,
                              (ctx) => StudentsOfClassScreen(
                                    classId: classId,
                                  ));
                          qClass.run();
                        },
                      ),
                    ],
                  ),

                QueryDisplay(q: qDelete),

                // lessons
                SizedBox(height: 8),
                Text(
                  'Lessons',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 8),
                QueryDisplay(q: qLessons),
                if (qLessons.value != null)
                  ...qLessons.value!.reversed.map((l) => LessonCard(
                        less: l,
                        onTap: () async {
                          await navigate(context, (c) => LessonDetailsScreen(lessonId: l.id, classId: cls.id));
                          qLessons.run();
                        },
                      )),
                if (qLessons.value != null && qLessons.value!.isEmpty) Text('No lessons'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
