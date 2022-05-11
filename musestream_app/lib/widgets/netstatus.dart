import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/transactions.dart';

class NetStatus extends HookConsumerWidget {
  final bool mod;
  const NetStatus({Key? key, this.mod = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final transactions = ref.watch(Transactions.provider);

    return !core.online
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Chip(
                    label: Text(
                      mod ? 'Offline - changes will be applied after connection' : 'Offline - displaying cached data',
                    ),
                    avatar: Icon(Icons.warning_rounded),
                  ),
                  if (transactions.queue.isNotEmpty)
                    Chip(
                      label: Text('Transactions waiting: ${transactions.queue.length}'),
                      avatar: Icon(Icons.warning_rounded),
                    ),
                ],
              )
            ],
          )
        : SizedBox();
  }
}
