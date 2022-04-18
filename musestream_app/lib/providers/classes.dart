import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';

class Classes extends ChangeNotifier {
  List<Class> myClasses = [];
  Core core;

  Classes(this.core);

  static final provider = ChangeNotifierProvider((ref) {
    final classes = Classes(ref.read(Core.provider));

    ref.listen<Core>(Core.provider, (previous, next) {
      classes.core = next;
    });

    return classes;
  });

  Future<void> getMine() async {
    print(core.dio.options.headers);

    final res = await core.handle<List<dynamic>>(core.dio.get('/classes'), {
      400: (r) => throw ApiErr('Wrong credentials!', r),
    });

    myClasses = res.data!.map((j) => Class.fromJson(j)).toList();
    print('<> classes fetched');
    notifyListeners();
  }
}
