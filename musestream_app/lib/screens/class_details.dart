import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/classes.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/lessons.dart';
import 'package:musestream_app/screens/class_files.dart';
import 'package:musestream_app/screens/edit_class.dart';
import 'package:musestream_app/screens/edit_lesson.dart';
import 'package:musestream_app/screens/lesson_details.dart';
import 'package:musestream_app/screens/students_of_class.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/lesson_card.dart';
import 'package:musestream_app/widgets/netstatus.dart';

class ClassDetailsScreen extends HookConsumerWidget {
  final int classId;

  const ClassDetailsScreen({Key? key, required this.classId}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final classes = ref.watch(Classes.provider);
    final lessons = ref.watch(Lessons.provider);
    final targetRequest = useRef<ClassRequest?>(null);

    final cls = classes.items[classId.toString()];
    final lessonsItems = lessons.getByClass(classId);

    final qClass = useQuery(useCallback(() => classes.fetchOne(classId), [core]), activate: true);
    final qLessons = useQuery(useCallback(() => lessons.fetchLessons(classId), [core]), activate: true);

    final qDelete = useQuery<void>(
      useCallback(() => core.handle(core.dio.delete('/classes/$classId')), [core]),
      onSuccess: (v) async {
        Navigator.of(context).pop();
      },
    );

    final qClassRequests = useQuery<List<ClassRequest>>(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<List<dynamic>>('/classes/$classId/requests'));
        return resp.data!.map((j) => ClassRequest.fromJson(j)).toList();
      }, [core]),
      activate: true,
    );

    final qDeleteRequest = useQuery<void>(
      useCallback(() async {
        await core.handle(core.dio.delete('/requests/${targetRequest.value?.id}'));
      }, [core]),
      onSuccess: (v) async {
        qClassRequests.run();
      },
    );

    final qAcceptRequest = useQuery<void>(
      useCallback(() async {
        await core.handle(core.dio.post('/requests/${targetRequest.value?.id}'));
      }, [core]),
      onSuccess: (v) async {
        qClassRequests.run();
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
                qClassRequests.run();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NetStatus(),
            QueryDisplay(q: qClass),
            Padding(
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
                  if (core.user?.type == 'teacher') ...[
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
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Students of class'),
                      onPressed: () async {
                        await navigate(
                          context,
                          (ctx) => StudentsOfClassScreen(
                            classId: classId,
                          ),
                        );
                        qClass.run();
                      },
                    ),
                  ],
                  QueryDisplay(q: qDelete),

                  // files
                  ElevatedButton(
                    child: Text('Class files'),
                    style: ElevatedButton.styleFrom(primary: Colors.teal),
                    onPressed: () async {
                      await navigate(
                        context,
                        (ctx) => ClassFilesScreen(
                          classId: classId,
                        ),
                      );
                      qClass.run();
                    },
                  ),

                  SizedBox(height: 16),

                  if (core.user?.type == 'teacher') ...[
                    // requests
                    Text(
                      'Class Requests',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 8),
                    QueryDisplay<List<ClassRequest>>(
                      q: qClassRequests,
                      val: (reqs) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: reqs!
                            .map((r) => Container(
                                  width: double.infinity,
                                  child: Card(
                                    margin: EdgeInsets.all(8),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('From: ${r.student?.fullName}'),
                                                Text('Message: ${r.message}'),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.done),
                                            onPressed: () async {
                                              targetRequest.value = r;
                                              qAcceptRequest.run();
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () async {
                                              targetRequest.value = r;
                                              qDeleteRequest.run();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    QueryDisplay(q: qAcceptRequest),
                    QueryDisplay(q: qDeleteRequest),
                  ],

                  // lessons
                  SizedBox(height: 8),
                  Text(
                    'Lessons',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 8),
                  QueryDisplay(q: qLessons),
                  ...lessonsItems.reversed.map((l) => LessonCard(
                        less: l,
                        onTap: () async {
                          await navigate(context, (c) => LessonDetailsScreen(lessonId: l.id, classId: cls.id));
                          qLessons.run();
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
