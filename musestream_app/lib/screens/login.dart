import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  child: FlatButton(
                    child: Text(
                      'LogIn',
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {},
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  child: FlatButton(
                    child: Text(
                      'Register',
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {},
                  ))
            ],
          ),
        ));
  }
}
