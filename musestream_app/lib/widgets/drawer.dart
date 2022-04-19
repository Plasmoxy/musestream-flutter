import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/screens/my_classes.dart';
import 'package:musestream_app/screens/rtc_test.dart';
import 'package:musestream_app/screens/settings.dart';
import 'package:musestream_app/utils/util.dart';

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            child: SizedBox(
              height: 64,
              child: DrawerHeader(
                child: Row(
                  children: [
                    Text(
                      'MuseStream',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      core.user?.type ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ListTile(
            title: const Text('My classes'),
            onTap: () {
              navigate(context, (ctx) => MyClassesScreen(), replace: true, toFirst: true);
            },
          ),

          // student
          if (core.user?.type == 'student') ...[],

          ListTile(
            title: const Text('Debug screen'),
            onTap: () {
              navigate(context, (ctx) => DebugScreen(), replace: true, toFirst: true);
            },
          ),
          ListTile(
            title: const Text('RTC testing'),
            onTap: () {
              navigate(context, (ctx) => RTCTestScreen(), replace: true, toFirst: true);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              navigate(context, (ctx) => SettingsScreen(), replace: true, toFirst: true);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              core.logout();
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(core.debug),
          )
        ],
      ),
    );
  }
}
