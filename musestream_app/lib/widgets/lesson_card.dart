import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/lesson_details.dart';
import 'package:musestream_app/utils/util.dart';

// Component to render a class
class LessonCard extends StatelessWidget {
  final Lesson less;
  final void Function()? onTap;

  const LessonCard({
    Key? key,
    required this.less,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.timer,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // for esample
                  children: [
                    Text(
                      'Start: ' + formatDate(less.start),
                      style: TextStyle(fontSize: 16), // for example
                    ),
                    Text(
                      'End:   ' + formatDate(less.end),
                      style: TextStyle(fontSize: 16), // for example
                    ),

                    // if populated with student, add name
                    if (less.classStudent?.student?.fullName != null) Text('Student: ' + less.classStudent!.student!.fullName),

                    Text(
                      less.notes,
                      style: TextStyle(fontSize: 12), // for example
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
