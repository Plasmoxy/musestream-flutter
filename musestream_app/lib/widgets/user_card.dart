import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';

// Component to render a class
class UserCard extends StatelessWidget {
  final User usr;
  final void Function()? onTap;
  final void Function()? onDelete;

  const UserCard({
    Key? key,
    required this.usr,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.person,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usr.fullName,
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '(${usr.name})',
                    ),
                    Text(usr.type),
                  ],
                ),
              ),
              SizedBox(width: 16),
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
