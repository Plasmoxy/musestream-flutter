import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/edit_lesson.dart';
import 'package:musestream_app/screens/lesson_details.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class StudentLessonsScreen extends HookConsumerWidget {
  final int studentId;
  final int classId;

  const StudentLessonsScreen({
    Key? key,
    required this.studentId,
    required this.classId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    final qLessons = useQuery<List<Lesson>>(
      useCallback(() async {
        final resp = await core.handle(
          core.dio.get<List<dynamic>>('/classes/$classId/students/$studentId/lessons'),
        );
        return resp.data!.map((j) => Lesson.fromJson(j)).toList();
      }, [core]),
      activate: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student\'s lessons'),
        actions: [
          IconButton(
              onPressed: () {
                qLessons.run();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: QueryDisplay<List<Lesson>>(
          q: qLessons,
          val: (lessons) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QueryDisplay(q: qLessons),
                ...lessons!.reversed.map(
                  (l) => LessonCard(
                    less: l,
                    onTap: () async {
                      await navigate(context, (c) => LessonDetailsScreen(lessonId: l.id, classId: classId));
                      qLessons.run();
                    },
                  ),
                ),
                if (qLessons.value != null && qLessons.value!.isEmpty) Text('No lessons'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await navigate(
              context,
              (ctx) => EditLessonScreen(
                    classId: classId,
                    studentId: studentId,
                  ));
          qLessons.run();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
