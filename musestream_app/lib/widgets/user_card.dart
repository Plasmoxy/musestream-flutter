import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';

// Component to render a class
class UserCard extends StatelessWidget {
  final User usr;

  const UserCard({
    Key? key,
    required this.usr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usr.name,
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(usr.type),
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
