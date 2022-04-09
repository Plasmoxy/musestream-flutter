import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/screens/debug.dart';

void main() {
  runApp(const App());
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'MuseStream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DebugScreen(),
    );
  }
}
