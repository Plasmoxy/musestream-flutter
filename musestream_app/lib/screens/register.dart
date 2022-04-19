import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/utils/util.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final nameCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    final fullNameCtrl = useTextEditingController();
    final serverCtrl = useTextEditingController(text: kIsWeb ? 'http://localhost' : 'http://10.0.2.2');
    final form = useMemoized(() => GlobalKey<FormState>());

    final queryRegister = useQuery<void>(
      useCallback(
        () => core.register(nameCtrl.text, passwordCtrl.text, fullNameCtrl.text, serverCtrl.text),
        [core],
      ),
      onSuccess: (v) async {
        await showInfoDialog(context, 'Registered', 'Sucessfully registered');
        Navigator.of(context).pop();
      },
    );

    final submit = useCallback(() {
      if (form.currentState?.validate() ?? false) {
        queryRegister.run();
      }
    }, [form]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MuseStream"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 45),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Username'),
                        ),
                        controller: nameCtrl,
                        validator: notEmpty,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password"),
                        ),
                        controller: passwordCtrl,
                        validator: (v) => (v?.length ?? 0) < 8 ? 'Password must be at least 8 characters.' : null,
                        obscureText: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Full name"),
                        ),
                        controller: fullNameCtrl,
                        validator: notEmpty,
                        obscureText: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Server address'),
                        ),
                        controller: serverCtrl,
                        validator: notEmpty,
                      ),
                      SizedBox(height: 10),
                      QueryDisplay<void>(
                        q: queryRegister,
                        val: (v) => Text('Registered !'),
                        err: (q) => Text(q.errMsg, style: tsErr),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                            child: Text(
                              'Sign Up',
                            ),
                            onPressed: submit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
