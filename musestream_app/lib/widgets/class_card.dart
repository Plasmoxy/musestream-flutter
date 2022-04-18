import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';

// Component to render a class
class ClassCard extends StatelessWidget {
  final Class cls;
  final void Function()? onTap;

  const ClassCard({
    Key? key,
    required this.cls,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
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
                Icons.school,
                color: Colors.white,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // for esample
                  children: [
                    Text(
                      cls.title,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'with ' + (cls.teacher?.fullName ?? '?'),
                      style: TextStyle(color: Colors.white),
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
