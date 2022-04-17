import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';

class Core extends ChangeNotifier {
  int count = 0;
  final dio = Dio();

  // user stuff
  TokenData? tokenData;
  User? user;
  bool get loggedIn => user != null && tokenData != null;

  Core() {
    // intercept error 401 for auth non logged
    dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      print(e.toString());
      return handler.next(e);
    }));
    dio.options.baseUrl = 'http://localhost';
  }

  static final provider = ChangeNotifierProvider((ref) {
    return Core();
  });

  void updateToken(TokenData t) {
    tokenData = t;
    if (tokenData?.bearer != null) dio.options.headers['authorization'] = 'Bearer ${tokenData!.bearer}';
    notifyListeners();
  }
}
