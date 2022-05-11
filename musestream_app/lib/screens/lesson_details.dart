import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/lessons.dart';
import 'package:musestream_app/providers/transactions.dart';
import 'package:musestream_app/screens/call_screen.dart';
import 'package:musestream_app/screens/edit_lesson.dart';
import 'package:musestream_app/utils/util.dart';

class LessonDetailsScreen extends HookConsumerWidget {
  final int lessonId;
  final int classId;

  const LessonDetailsScreen({
    Key? key,
    required this.lessonId,
    required this.classId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final transactions = ref.watch(Transactions.provider);
    final lessons = ref.watch(Lessons.provider);

    final lesson = lessons.items['$classId/$lessonId'];

    final qLesson = useQuery(
      useCallback(() => lessons.fetchLessons(classId), [core, lessonId]),
      activate: core.online,
    );

    final qDelete = useQuery<void>(
      useCallback(() async {
        await core.handle(core.dio.delete('/lessons/$lessonId'));
      }, [core]),
      onSuccess: (v) async {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [IconButton(onPressed: qLesson.run, icon: Icon(Icons.refresh))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QueryDisplay(q: qLesson),
            if (lesson != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(36),
                child: Row(
                  children: [
                    Icon(Icons.timer, size: 32),
                    SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start: ' + formatDate(lesson.start),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'End: ' + formatDate(lesson.end),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (lesson != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text(core.user?.type == 'teacher'
                            ? 'Start call'
                            : lesson.roomId == null
                                ? 'The lesson hasn\'t started yet'
                                : 'Join video call'),
                        onPressed: (core.user?.type == 'student' && lesson.roomId == null)
                            ? null
                            : () async {
                                await navigate(context, (ctx) => CallScreen(lessonId: lesson.id));
                                qLesson.run();
                              },
                      ),

                      // actions
                      if (core.user?.type == 'teacher')
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                await navigate(
                                  context,
                                  (ctx) => EditLessonScreen(
                                    toEdit: lesson,
                                    classId: classId,
                                    studentId: lesson.classStudent!.studentId,
                                  ),
                                );
                                qLesson.run();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                if (await showConfirmDialog(context, 'Delete lesson?', 'Are you sure?')) {
                                  qDelete.run();
                                }
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                  QueryDisplay(q: qDelete),
                  SizedBox(height: 16),
                  Text(
                    'Notes:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(lesson.notes),
                ]),
              )
          ],
        ),
      ),
    );
  }
}
