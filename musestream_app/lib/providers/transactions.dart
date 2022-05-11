import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/allclasses.dart';
import 'package:musestream_app/providers/classes.dart';
import 'package:musestream_app/providers/lessons.dart';
import 'package:musestream_app/providers/requests.dart';
import 'package:musestream_app/providers/students.dart';

typedef Transaction = Future<dynamic> Function();

class Transactions extends ChangeNotifier {
  Core core;

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

      // if we logged out delete files SPAGHET CODE WARNING
      if (!trans.core.loggedIn) {
        print('NOT LOGGED IN, DELETING CACHE');
        ref.read(AllClasses.provider).delete();
        ref.read(Classes.provider).delete();
        ref.read(Lessons.provider).delete();
        ref.read(Requests.provider).delete();
        ref.read(Students.provider).delete();
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
    while (queue.isNotEmpty) {
      try {
        await queue.removeFirst()();
      } catch (err) {
        print(err);
      }
    }
    print('Transactions done.');
  }
}
