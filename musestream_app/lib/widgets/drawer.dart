import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/screens/rtc_test.dart';

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
              child: const DrawerHeader(
                child: Text(
                  'MuseStream',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Debug screen'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DebugScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('RTC TEST'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => RTCTestScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {},
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
