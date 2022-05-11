import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/allclasses.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/lessons.dart';
import 'package:musestream_app/providers/persisted.dart';
import 'package:musestream_app/providers/requests.dart';
import 'package:musestream_app/providers/students.dart';

class Classes extends ChangeNotifier with Persisted<String, Class> {
  Core core;

  Classes(this.core, this.allClasses, this.lessons, this.students, this.requests);

  @override
  String get persistId => 'classes';

  @override
  Class fromJson(dynamic j) => Class.fromJson(j);

  @override
  dynamic toJson(Class t) => t.toJson();

  AllClasses allClasses;
  Lessons lessons;
  Students students;
  Requests requests;

  static final provider = ChangeNotifierProvider((ref) {
    final core = ref.read(Core.provider);
    final allClasses = ref.read(AllClasses.provider);
    final lessons = ref.read(Lessons.provider);
    final students = ref.read(Students.provider);
    final requests = ref.read(Requests.provider);

    // SPAGHET
    final classes = Classes(core, allClasses, lessons, students, requests);

    ref.listen<Core>(Core.provider, (previous, next) {
      classes.core = next;
    });

    classes.reset();

    return classes;
  });

  void reset() {
    // init
    Future.delayed(Duration.zero, () async {
      // load from offline
      print('INIT loading from cache');
      await load();
      await lessons.load();
      await students.load();
      await requests.load();
      await allClasses.load();

      // load my classes
      print('INIT loading my classes');
      await getMine();

      print('INIT loading all classes');
      allClasses.fetchAll();

      // fetch lessons for all classes that we loaded
      print('INIT Fetching lessons for loaded classes.');
      for (final c in items.values) {
        lessons.fetchLessons(c.id);
      }

      // fetch students for all classes that we loaded
      if (core.user?.type == 'teacher') {
        print('INIT-teacher Fetching students for loaded classes.');
        for (final c in items.values) {
          students.fetchClassStudents(c.id);
        }

        print('INIT-teacher Fetching requests for loaded classes.');
        for (final c in items.values) {
          requests.fetchClassRequests(c.id);
        }
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> getMine() async {
    final res = await core.handle<List<dynamic>>(core.dio.get('/classes'));
    items = {for (var c in res.data!.map((j) => Class.fromJson(j))) c.id.toString(): c};
    print('<> classes fetched');
    save();
    notifyListeners();
  }

  Future<void> fetchOne(int id) async {
    final resp = await core.handle(core.dio.get<dynamic>('/classes/$id'));
    final c = Class.fromJson(resp.data);
    items[c.id.toString()] = c;
    save();
    notifyListeners();
    print('Fetched one class $id');
  }
}
