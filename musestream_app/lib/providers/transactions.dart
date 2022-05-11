import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';

class Transactions extends ChangeNotifier {
  Core core;

  Transactions(this.core);

  static final provider = ChangeNotifierProvider((ref) {
    final trans = Transactions(
      ref.read(Core.provider),
    );

    ref.listen<Core>(Core.provider, (previous, next) {
      trans.core = next;
    });

    return trans;
  });
}
