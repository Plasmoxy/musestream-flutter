import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(54),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 45),
                )),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: nameCtrl,
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                controller: passwordCtrl,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text(
                    'LogIn',
                  ),
                  onPressed: () {},
                )),
            Container(
                margin: EdgeInsets.all(5),
                child: ElevatedButton(
                  child: Text(
                    'Sign up',
                  ),
                  onPressed: () {},
                ))
          ],
        ),
      ),
    );
  }
}
