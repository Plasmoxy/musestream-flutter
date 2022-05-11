import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/persisted.dart';

class AllClasses extends ChangeNotifier with Persisted<String, Class> {
  Core core;

  AllClasses(this.core);

  @override
  String get persistId => 'classesall';

  @override
  Class fromJson(dynamic j) => Class.fromJson(j);

  @override
  dynamic toJson(Class t) => t.toJson();

  static final provider = ChangeNotifierProvider((ref) {
    final classes = AllClasses(ref.read(Core.provider));

    ref.listen<Core>(Core.provider, (previous, next) {
      classes.core = next;
    });

    // init
    Future.delayed(Duration.zero, () async {
      await classes.load();
      await classes.fetchAll();
    });

    return classes;
  });

  Future<void> fetchAll() async {
    print(core.dio.options.headers);
    final res = await core.handle<List<dynamic>>(core.dio.get('/classes/all'));
    items = {for (var c in res.data!.map((j) => Class.fromJson(j))) c.id.toString(): c};
    print('<> all classes');
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
