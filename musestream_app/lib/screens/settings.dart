import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/register.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/drawer.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final emailCtrl = useTextEditingController();
    final fullNameCtrl = useTextEditingController();
    final form = useMemoized(() => GlobalKey<FormState>());

    final queryUpdate = useQuery(useCallback(
      () async {
        await core.handle(core.dio.put('/updateSelf', data: {
          'email': emailCtrl.text,
          'fullName': fullNameCtrl.text,
        }));
      },
      [core],
    ));

    final submit = useCallback(() {
      if (form.currentState?.validate() ?? false) {
        queryUpdate.run();
      }
    }, [form]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User settings"),
      ),
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Full name'),
                    ),
                    controller: fullNameCtrl,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                    ),
                    controller: emailCtrl,
                  ),
                  SizedBox(height: 10),
                  QueryDisplay<void>(
                    q: queryUpdate,
                    val: (v) => Text('Updated !'),
                    err: (q) => Text(q.errMsg, style: tsErr),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        child: Text(
                          'Update',
                        ),
                        onPressed: submit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
