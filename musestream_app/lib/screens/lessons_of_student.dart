import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/lessons.dart';
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
    final lessons = ref.watch(Lessons.provider);
    final sless = lessons.getByClassAndStudent(classId, studentId);

    final qLessons = useQuery(
      useCallback(() => lessons.fetchLessons(classId), [core]),
      activate: core.online,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QueryDisplay(q: qLessons),
              ...sless.map(
                (l) => LessonCard(
                  less: l,
                  onTap: () async {
                    await navigate(
                        context,
                        (c) => LessonDetailsScreen(
                              lessonId: l.id,
                              classId: classId,
                            ));
                    qLessons.run();
                  },
                ),
              ),
            ],
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
