import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<T?> navigate<T>(BuildContext context, Widget Function(BuildContext) builder, {replace = false, toFirst = false}) {
  if (toFirst) Navigator.of(context).popUntil((route) => route.isFirst);
  if (replace) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
  } else {
    return Navigator.of(context).push<T>(MaterialPageRoute(builder: builder));
  }
}

String? notEmpty(String? value) => value == null
    ? null
    : value.isEmpty
        ? 'Cannot be empty!'
        : null;

final tsErr = TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent);
final tsSucc = TextStyle(fontWeight: FontWeight.bold, color: Colors.green[600]);

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Chyba',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

Future<bool> showConfirmDialog(BuildContext context, String? title, String? content, [String yesText = 'Yes', String noText = 'No']) async {
  final diaResult = await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: title == null ? null : Text(title),
      content: content == null ? null : Text(content),
      actions: <Widget>[
        TextButton(
            child: Text(
              noText,
              style: TextStyle(color: Colors.black87),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            }),
        TextButton(
            child: Text(
              yesText,
              style: TextStyle(
                color: Colors.blue[800],
              ),
            ),
            onPressed: () {
              // showDialog returns the future of navigator pop
              Navigator.of(ctx).pop(true);
            }),
      ],
    ),
  );
  return diaResult ?? false;
}

Future<void> showInfoDialog(
  BuildContext context,
  String? title,
  String? content,
) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: title == null ? null : Text(title),
      content: content == null ? null : Text(content),
      actions: <Widget>[
        TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.blue[800],
              ),
            ),
            onPressed: () {
              // showDialog returns the future of navigator pop
              Navigator.of(ctx).pop();
            }),
      ],
    ),
  );
}

String formatDate(DateTime date) {
  return DateFormat("EEE dd. MM. yyyy - HH:mm").format(date);
}
