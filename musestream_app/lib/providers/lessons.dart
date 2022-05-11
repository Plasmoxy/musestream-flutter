import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/classes.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/persisted.dart';

class Lessons extends ChangeNotifier with Persisted<String, Lesson> {
  Core core;

  Lessons(this.core);

  @override
  String get persistId => 'lessons';

  @override
  Lesson fromJson(dynamic j) => Lesson.fromJson(j);

  @override
  dynamic toJson(Lesson t) => t.toJson();

  static final provider = ChangeNotifierProvider((ref) {
    final lessons = Lessons(ref.read(Core.provider));
    return lessons;
  });

  List<Lesson> getByClass(int cid) => items.entries.where((e) => e.key.startsWith('$cid/')).map((e) => e.value).toList();

  Future<void> fetchLessons(int classId) async {
    final res = await core.handle<List<dynamic>>(core.dio.get('/classes/$classId/lessons'));
    items = {for (var l in res.data!.map((j) => Lesson.fromJson(j))) '$classId/${l.id}': l};
    print('<> lessons fetched for class $classId');
    await save();
    notifyListeners();
  }
}
