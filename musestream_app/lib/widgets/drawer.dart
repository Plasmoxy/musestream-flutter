import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/screens/debug.dart';

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            child: SizedBox(
              height: 64,
              child: const DrawerHeader(
                child: Text('MuseStream - student'),
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
            title: const Text('Log out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
