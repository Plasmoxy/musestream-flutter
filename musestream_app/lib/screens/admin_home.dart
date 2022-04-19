import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/widgets/drawer.dart';
import 'package:musestream_app/widgets/user_typed.dart';

class AdminHomeScreen extends HookConsumerWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    final qUsers = useQuery<List<User>>(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<List<dynamic>>('/users'));
        return resp.data!.map((j) => User.fromJson(j)).toList();
      }, [core]),
      activate: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administration"),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Text('student | teacher | admin')
                ],
              ),
              SizedBox(height: 16),
              QueryDisplay(q: qUsers),
              if (qUsers.value != null)
                ...qUsers.value!.map(
                  (usr) => UserTyped(
                    usr: usr,
                    onChange: qUsers.run,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
