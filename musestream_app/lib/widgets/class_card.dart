import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';
import 'package:musestream_app/screens/login.dart';

// Component to render a class
class ClassCard extends StatelessWidget {
  final Class cls;

  const ClassCard({
    Key? key,
    required this.cls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // REFACTOR MENU = Ctrl Shift R
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DebugScreen(),
          ));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // for esample
                  children: [
                    Text(
                      cls.title,
                      style: TextStyle(fontSize: 30), // for example
                    ),
                    Text(cls.teacher?.name ?? ''),
                  ],
                ),
              ),
              ClipOval(
                child: Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                  width: 60,
                  height: 60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
