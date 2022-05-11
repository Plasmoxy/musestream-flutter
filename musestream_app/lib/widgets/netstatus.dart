import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';

class NetStatus extends HookConsumerWidget {
  final bool mod;
  const NetStatus({Key? key, this.mod = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    return !core.online
        ? Chip(
            label: Text(
              mod ? 'Offline - changes will be applied after connection' : 'Offline - displaying cached data',
            ),
            avatar: Icon(Icons.warning_rounded),
          )
        : SizedBox();
  }
}
