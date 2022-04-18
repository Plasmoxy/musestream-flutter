import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/widgets/lesson_card.dart';

class ClassDetailsScreen extends HookConsumerWidget {
  final Class cls;

  const ClassDetailsScreen({Key? key, required this.cls}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    final qLessons = useQuery(useCallback(() async {}, []));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(36),
                  child: Row(
                    children: [
                      Icon(Icons.school),
                      SizedBox(width: 32),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cls.title,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.left, // for example
                            ),
                            Text(
                              'with ' + (cls.teacher?.fullName ?? ''),
                              style: TextStyle(fontSize: 16),
                            ),
                            Text('Instrument: ' + cls.instrument),
                            Text(cls.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              Text(
                'Upcoming lessons',
                style: TextStyle(fontSize: 25),
              ),
              LessonCard(less: MOCK_LESSON),
              LessonCard(less: MOCK_LESSON),
              Text(
                'Past lessons',
                style: TextStyle(fontSize: 25),
              ),
              LessonCard(less: MOCK_LESSON),
              LessonCard(less: MOCK_LESSON),
            ],
          ),
        ),
      ),
    );
  }
}
