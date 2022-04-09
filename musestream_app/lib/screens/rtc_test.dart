import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/widgets/drawer.dart';

class RTCTestScreen extends HookConsumerWidget {
  const RTCTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = useFuture(useMemoized(
      () => FirebaseFirestore.instance.collection('klobasy').get(),
    ));

    return Scaffold(
      appBar: AppBar(title: Text('RTC Test Screen')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kolbasy request paci sa:'),
            if (snapshot.hasData)
              Text(snapshot.data!.docs
                  .map((d) => {
                        'id': d.id,
                        ...d.data(),
                      })
                  .toString()),
            if (snapshot.hasError) Text(snapshot.error!.toString()),
          ],
        ),
      ),
    );
  }
}
