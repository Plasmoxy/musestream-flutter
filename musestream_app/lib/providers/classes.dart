import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/persisted.dart';

class Classes extends ChangeNotifier with Persisted<String, Class> {
  Core core;

  Classes(this.core);

  @override
  String get persistId => 'classes';

  @override
  Class fromJson(dynamic j) => Class.fromJson(j);

  @override
  dynamic toJson(Class t) => t.toJson();

  static final provider = ChangeNotifierProvider((ref) {
    final classes = Classes(ref.read(Core.provider));

    ref.listen<Core>(Core.provider, (previous, next) {
      classes.core = next;
    });

    classes.load();

    return classes;
  });

  Future<void> getMine() async {
    print(core.dio.options.headers);
    final res = await core.handle<List<dynamic>>(core.dio.get('/classes'));
    items = {for (var c in res.data!.map((j) => Class.fromJson(j))) c.id.toString(): c};
    print('<> classes fetched');
    await save();
    notifyListeners();
  }
}
