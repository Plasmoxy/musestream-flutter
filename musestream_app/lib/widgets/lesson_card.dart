import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/login.dart';

// Component to render a class
class LessonCard extends StatelessWidget {
  final Lesson less;

  const LessonCard({
    Key? key,
    required this.less,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          ));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // for esample
                  children: [
                    Text(
                      less.start,
                      style: TextStyle(fontSize: 20), // for example
                    ),
                    Text(
                      less.end,
                      style: TextStyle(fontSize: 20), // for example
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
