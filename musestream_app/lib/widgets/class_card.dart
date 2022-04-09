import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/login.dart';

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
          // navigate to class detail screen !
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          ));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          // co je vnutri tej karty ?
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
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
