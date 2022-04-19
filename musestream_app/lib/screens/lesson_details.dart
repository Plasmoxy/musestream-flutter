import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/call_screen.dart';
import 'package:musestream_app/utils/util.dart';

class LessonDetailsScreen extends HookConsumerWidget {
  final int lessonId;

  const LessonDetailsScreen({Key? key, required this.lessonId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    final qLesson = useQuery(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<dynamic>('/lessons/$lessonId'));
        return Lesson.fromJson(resp.data);
      }, [core, lessonId]),
      activate: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [IconButton(onPressed: qLesson.run, icon: Icon(Icons.refresh))],
      ),
      body: SingleChildScrollView(
        child: QueryDisplay<Lesson>(
          q: qLesson,
          val: (lesson) => Column(
            children: [
              Container(
                child: InkWell(
                  child: Container(
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
                                'Start: ' + formatDate(lesson!.start),
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
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text(core.user?.type == 'teacher'
                            ? 'Start call'
                            : lesson.roomId == null
                                ? 'The lesson hasn\'tstarted yet'
                                : 'Join video call'),
                        onPressed: (core.user?.type == 'student' && lesson.roomId == null)
                            ? null
                            : () async {
                                await navigate(context, (ctx) => CallScreen(lessonId: lesson.id));
                                qLesson.run();
                              },
                      ),
                      if (core.user?.type == 'teacher')
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent,
                          onPressed: () => {},
                        ),
                    ],
                  ),
                  Text(lesson.toJson().toString()),
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
      ),
    );
  }
}
