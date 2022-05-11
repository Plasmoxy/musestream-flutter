import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

abstract class Persisted<String, T> implements ChangeNotifier {
  String get persistId;
  Map<String, T> items = {};

  T fromJson(dynamic j);
  dynamic toJson(T t);

  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$persistId.json');
  }

  Future<void> load() async {
    final file = await _file;
    if (await file.exists()) {
      try {
        final jsonString = await file.readAsString();
        final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
        items = Map.fromEntries(decoded.entries.map((e) => MapEntry(e.key, fromJson(e.value))));
        print("Loaded $persistId from cache file.");
        notifyListeners();
      } catch (e) {
        print("ERROR loading $persistId json file, clearing it.");
        print(e);
        await file.delete();
        items = {};
        notifyListeners();
      }
    } else {
      print("$persistId file doesn't exist, emptying $persistId.");
      items = {};
      notifyListeners();
    }
  }

  Future<void> save() async {
    final file = await _file;
    final outmap = {for (final entry in items.entries) entry.key.toString(): toJson(entry.value)};
    final jsonString = jsonEncode(outmap);
    await file.writeAsString(jsonString);
    print("Saved $persistId to file.");
    notifyListeners();
  }

  Future<void> delete() async {
    final file = await _file;
    await file.delete();
    print("Deleted $persistId file");
    items = {}; // reset items
    notifyListeners();
  }
}
