import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/my_classes.dart';
import 'firebase_options.dart';

void main() async {
  // init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // run
  runApp(ProviderScope(
    child: App(),
  ));
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    return MaterialApp(
      title: 'MuseStream',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: core.loggedIn ? Colors.blue : Colors.grey,
      ),
      home: core.loggedIn ? MyClassesScreen() : LoginScreen(),
    );
  }
}
