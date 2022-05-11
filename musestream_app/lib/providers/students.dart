import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/persisted.dart';

class Students extends ChangeNotifier with Persisted<String, User> {
  Core core;

  Students(this.core);

  @override
  String get persistId => 'students';

  @override
  User fromJson(dynamic j) => User.fromJson(j);

  @override
  dynamic toJson(User t) => t.toJson();

  static final provider = ChangeNotifierProvider((ref) {
    final stds = Students(ref.read(Core.provider));
    return stds;
  });

  Future<void> fetchClassStudents(int classId) async {
    final res = await core.handle<List<dynamic>>(core.dio.get('/classes/$classId/students'));
    items = {for (var s in res.data!.map((j) => User.fromJson(j))) '$classId/${s.id}': s};
    print('<> students fetched for class $classId');
    await save();
    notifyListeners();
  }
}
