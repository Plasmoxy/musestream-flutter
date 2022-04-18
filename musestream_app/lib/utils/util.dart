import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget Function(BuildContext) builder, {replace = false, toFirst = false}) {
  if (toFirst) Navigator.of(context).popUntil((route) => route.isFirst);
  if (replace) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
  } else {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}

String? notEmpty(String? value) => value == null
    ? null
    : value.isEmpty
        ? 'Cannot be empty!'
        : null;

final tsErr = TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent);
