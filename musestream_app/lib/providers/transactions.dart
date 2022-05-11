import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';

typedef Transaction = Future<dynamic> Function();

class Transactions extends ChangeNotifier {
  Core core;
  bool running = false;

  Queue<Transaction> queue = Queue();

  Transactions(this.core);

  static final provider = ChangeNotifierProvider((ref) {
    final trans = Transactions(
      ref.read(Core.provider),
    );

    ref.listen<Core>(Core.provider, (previous, next) {
      trans.core = next;

      // if we are online, execute transactions
      if (trans.core.online) {
        trans.execute();
      }

      if (!trans.core.loggedIn) {
        trans.queue.clear();
      }
    });

    return trans;
  });

  Future<void> make(Transaction t) async {
    if (core.online) {
      await t(); // if online, immediately run transaction
      return;
    }

    // else add to transactions
    queue.add(t);
    print('Added a transaction!');
    notifyListeners();
  }

  Future<void> execute() async {
    print('Executing ${queue.length} transactions ...');
    running = true;
    notifyListeners();
    while (queue.isNotEmpty) {
      try {
        await queue.removeFirst()();
      } catch (err) {
        print(err);
      }
    }
    print('Transactions done.');
    running = false;
    notifyListeners();
  }
}
