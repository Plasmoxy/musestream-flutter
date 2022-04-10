import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(54),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 45),
                  )),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text(
                      'Sing up',
                    ),
                    onPressed: () {},
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    child: Text(
                      'Back to login',
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ));
  }
}
