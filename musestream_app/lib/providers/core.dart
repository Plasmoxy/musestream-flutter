import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';

class ApiErr implements Exception {
  String msg;
  Response<dynamic>? res;

  ApiErr(this.msg, this.res);

  @override
  String toString() => 'ApiErr[${res?.statusCode}] $msg';
}

class Core extends ChangeNotifier {
  int count = 0;
  final dio = Dio(BaseOptions(
    connectTimeout: 8000,
    receiveTimeout: 60000,
  ));

  // user stuff
  TokenData? loginData;

  bool get loggedIn => loginData != null;

  Core() {
    // intercept error 401 for auth non logged
    dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      print(e.toString());
      return handler.next(e);
    }));
    dio.options.baseUrl = 'http://10.0.2.2';
  }

  static final provider = ChangeNotifierProvider((ref) {
    return Core();
  });

  String get debug => 'logged: $loggedIn\nuser: ${loginData?.user.name}\ntype: ${loginData?.user.type}';

  // generic handler for server data
  // pass optional status code handler map and throw apierr using them to ez UI display
  Future<Response<T>> handle<T>(Future<Response<T>> future, [Map<int, dynamic Function(Response<dynamic>)>? codeHandlers]) async {
    try {
      return await future;
    } catch (e) {
      if (e is DioError) {
        // guard unauthorized
        if (e.response?.statusCode == 401) {
          print('Unauthorized !!!');
        }

        // handle custom status code hadnlers
        if (e.response != null && codeHandlers != null) {
          for (final entry in codeHandlers.entries) {
            if (e.response?.statusCode == entry.key) {
              entry.value(e.response!);
            }
          }
        }
      }
      rethrow;
    }
  }

  Future<void> login(String name, String pass) async {
    final res = await handle(dio.post('/login', data: {'name': name, 'password': pass}), {
      400: (r) => throw ApiErr('Wrong credentials!', r),
    });

    // setup login
    loginData = TokenData.fromJson(res.data);
    if (loginData != null) dio.options.headers['authorization'] = 'Bearer ${loginData!.token}';

    print('Logged in');
    notifyListeners();
  }

  Future<void> logout() async {
    loginData = null;
    dio.options.headers.remove('authorization');
    notifyListeners();
  }
}
