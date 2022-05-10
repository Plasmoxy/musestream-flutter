import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class Persisted<T> {
  String get persistId;
  List<T> items = [];

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
        final arr = jsonDecode(jsonString) as List<dynamic>;
        items = arr.map((j) => fromJson(j)).toList();
        print("Loaded $persistId from cache file.");
      } catch (e) {
        print("ERROR loading $persistId json file, clearing it.");
        await file.delete();
        items = [];
      }
    } else {
      print("$persistId file doesn't exist, emptying $persistId.");
      items = [];
    }
  }

  Future<void> save() async {
    final file = await _file;
    final jsonList = items.map((x) => toJson(x)).toList();
    final jsonString = jsonEncode(jsonList);
    await file.writeAsString(jsonString);
    print("Saved $persistId to file.");
  }
}
