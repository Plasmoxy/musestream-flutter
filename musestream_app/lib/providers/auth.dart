import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStore extends ChangeNotifier {
  String? token;
  int count = 0;

  static final provider = ChangeNotifierProvider((ref) => AuthStore());

  void inc() {
    count++;
    notifyListeners();
  }

  void setToken(String? t) {
    token = t;
    notifyListeners();
  }
}
