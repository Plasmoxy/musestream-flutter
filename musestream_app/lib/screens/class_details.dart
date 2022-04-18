import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/lesson_details.dart';
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
                  Container(
                    padding: const EdgeInsets.only(left: 36.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          child: Text('Delete'),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text('Students of class'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                // lessons
                Text(
                  'Lessons',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 8),
                QueryDisplay(q: qLessons),
                if (qLessons.value != null)
                  ...qLessons.value!.map((l) => LessonCard(
                        less: l,
                        onTap: () async {
                          await navigate(context, (c) => LessonDetailsScreen(lessonId: l.id));
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
