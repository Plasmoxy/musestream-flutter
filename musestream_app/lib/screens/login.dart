import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/screens/register.dart';
import 'package:musestream_app/utils/util.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final nameCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    final serverCtrl = useTextEditingController(text: kIsWeb ? 'http://localhost' : 'http://10.0.2.2');
    final form = useMemoized(() => GlobalKey<FormState>());

    final queryLogin = useQuery(useCallback(
      () => core.login(nameCtrl.text, passwordCtrl.text, serverCtrl.text),
      [],
    ));

    final submit = useCallback(() {
      if (form.currentState?.validate() ?? false) {
        queryLogin.run();
      }
    }, [form]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MuseStream"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 45),
                ),
                SizedBox(height: 24),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name'),
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
                  q: queryLogin,
                  val: (v) => Text('Logged in !'),
                  err: (q) => Text(q.errMsg, style: tsErr),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Text(
                        'Log in',
                      ),
                      onPressed: submit,
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      child: Text(
                        'Sign up',
                      ),
                      onPressed: () => navigate(context, (c) => RegisterScreen()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
