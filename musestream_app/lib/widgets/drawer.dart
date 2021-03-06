import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/admin_home.dart';
import 'package:musestream_app/screens/login.dart';
import 'package:musestream_app/screens/my_classes.dart';
import 'package:musestream_app/screens/request_class.dart';
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

          if (core.user?.type == 'student' || core.user?.type == 'teacher')
            ListTile(
              title: const Text('My classes'),
              onTap: () {
                navigate(context, (ctx) => MyClassesScreen(), replace: true, toFirst: true);
              },
            ),

          // student
          if (core.user?.type == 'student') ...[
            ListTile(
              title: const Text('Request class'),
              onTap: () {
                navigate(context, (ctx) => RequestClassesScreen(), replace: true, toFirst: true);
              },
            ),
          ],

          // admin
          if (core.user?.type == 'admin') ...[
            ListTile(
              title: const Text('Users'),
              onTap: () {
                navigate(context, (ctx) => AdminHomeScreen(), replace: true, toFirst: true);
              },
            ),
            ListTile(
              title: const Text('RTC testing'),
              onTap: () {
                navigate(context, (ctx) => RTCTestScreen(), replace: true, toFirst: true);
              },
            ),
          ],

          ListTile(
            title: const Text('Settings'),
            onTap: () {
              navigate(context, (ctx) => SettingsScreen(), replace: true, toFirst: true);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () async {
              await core.logout();
              navigate(context, (ctx) => LoginScreen());
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
