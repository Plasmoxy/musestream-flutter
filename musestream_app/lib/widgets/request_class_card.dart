import 'package:flutter/material.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/screens/debug.dart';

// Component to render a class
class RequestClassCard extends StatelessWidget {
  final RequestClass reqcls;

  const RequestClassCard({
    Key? key,
    required this.reqcls,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('kk'),
                    Text('dd'),
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
