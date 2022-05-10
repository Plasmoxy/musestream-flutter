import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/classes.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musestream_app/screens/admin_home.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/my_classes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  print('INITIALIZING APP');

  // init firebase
  print('INIT FIREBASE');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // load from preferences
  print('Loading preferences ...');
  final p = await SharedPreferences.getInstance();
  final loginStr = p.getString('loginData');
  final baseStr = p.getString('baseUrl');

  Core? initialCore;
  if (loginStr != null && baseStr != null) {
    try {
      final loginData = TokenData.fromJson(jsonDecode(loginStr));
      initialCore = Core(initial: loginData, baseUrl: baseStr);
    } catch (e) {
      print('Error loading prefs');
    }
  }

  print('Running');
  // run
  runApp(
    ProviderScope(
      child: App(),
      overrides: [
        // override with init data
        if (initialCore != null) Core.provider.overrideWithValue(initialCore),
      ],
    ),
  );
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
        primarySwatch: core.loggedIn
            ? core.loginData?.user.type == 'teacher'
                ? Colors.purple
                : Colors.blue
            : Colors.grey,
      ),
      home: core.loggedIn
          ? core.loginData?.user.type == 'admin'
              ? AdminHomeScreen()
              : MyClassesScreen()
          : LoginScreen(),
    );
  }
}
