import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/persisted.dart';

class Requests extends ChangeNotifier with Persisted<String, ClassRequest> {
  Core core;

  Requests(this.core);

  @override
  String get persistId => 'requests';

  @override
  ClassRequest fromJson(dynamic j) => ClassRequest.fromJson(j);

  @override
  dynamic toJson(ClassRequest t) => t.toJson();

  static final provider = ChangeNotifierProvider((ref) {
    final reqs = Requests(ref.read(Core.provider));

    ref.listen<Core>(Core.provider, (previous, next) {
      reqs.core = next;
    });

    return reqs;
  });

  List<ClassRequest> getByClass(int cid) => items.entries.where((e) => e.key.startsWith('$cid/')).map((e) => e.value).toList();

  Future<void> fetchClassRequests(int classId) async {
    final res = await core.handle<List<dynamic>>(core.dio.get('/classes/$classId/requests'));
    items = {for (var s in res.data!.map((j) => ClassRequest.fromJson(j))) '$classId/${s.id}': s};
    print('<> requests fetched for class $classId');
    await save();
    notifyListeners();
  }
}
