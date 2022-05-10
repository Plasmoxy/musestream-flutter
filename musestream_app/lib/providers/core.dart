import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiErr implements Exception {
  String msg;
  Response<dynamic>? res;

  ApiErr(this.msg, this.res);

  @override
  String toString() => 'ApiErr[${res?.statusCode}] $msg';
}

class Core extends ChangeNotifier {
  final dio = Dio(BaseOptions(
    connectTimeout: 2000,
    receiveTimeout: 10000,
  ));

  // user stuff
  TokenData? loginData;

  bool online = false;

  bool get loggedIn => loginData != null;
  User? get user => loginData?.user;

  Core({TokenData? initial, String? baseUrl}) {
    // intercept error 401 for auth non logged
    dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      print(e.toString());
      return handler.next(e);
    }));
    dio.options.baseUrl = 'http://10.0.2.2'; // default for emulator

    // from initial
    if (initial != null && baseUrl != null) {
      loginData = initial;
      dio.options.headers['authorization'] = 'Bearer ${loginData!.token}';
      dio.options.baseUrl = baseUrl;
      print('Initialized core from previous data.');
    }
  }

  static final provider = ChangeNotifierProvider((ref) {
    return Core();
  });

  String get debug => 'logged: $loggedIn\nuser: ${loginData?.user.name}\ntype: ${loginData?.user.type}\nonline: $online';

  // generic handler for server data
  // pass optional status code handler map and throw apierr using them to ez UI display
  Future<Response<T>> handle<T>(Future<Response<T>> future, [Map<int, dynamic Function(Response<dynamic>)>? codeHandlers]) async {
    try {
      final result = await future;

      if (!online) {
        online = true;
        notifyListeners();
      }

      return result;
    } catch (e) {
      if (e is DioError) {
        // guard unauthorized
        if (e.response?.statusCode == 401) {
          print('Unauthorized !!!');
          throw ApiErr('You are not authorized, please log out and log in.', e.response);
        }

        if (e.type == DioErrorType.connectTimeout) {
          if (online) {
            online = false;
            notifyListeners();
          }
          throw ApiErr('Connection error.', null);
        }
        if (e.type == DioErrorType.receiveTimeout) {
          if (online) {
            online = false;
            notifyListeners();
          }
          throw ApiErr('Error receiving (timeout)', null);
        }
        if (e.type == DioErrorType.other && e.error is SocketException) {
          if (online) {
            online = false;
            notifyListeners();
          }
          throw ApiErr('Connection error', null);
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

  Future<void> login(String name, String pass, String serverIp) async {
    dio.options.baseUrl = serverIp;

    final res = await handle(dio.post('/login', data: {'name': name, 'password': pass}), {
      400: (r) => throw ApiErr('The username or password is incorrect!', r),
    });

    // setup login
    loginData = TokenData.fromJson(res.data);
    if (loginData != null) dio.options.headers['authorization'] = 'Bearer ${loginData!.token}';

    print('Logged in');

    await savePrefs();
    print('Saved to prefs');
    notifyListeners();
  }

  Future<void> register(String name, String pass, String fullName, String serverIp) async {
    dio.options.baseUrl = serverIp;

    await handle(
      dio.post('/register', data: {
        'name': name,
        'password': pass,
        'fullName': fullName,
      }),
      {
        400: (r) => throw ApiErr('This username has already been used', r),
      },
    );
  }

  Future<void> logout() async {
    loginData = null;
    dio.options.headers.remove('authorization');
    await savePrefs();
    print('Saved to prefs');
    notifyListeners();
  }

  Future<void> savePrefs() async {
    final p = await SharedPreferences.getInstance();

    await p.setString('baseUrl', dio.options.baseUrl);
    if (loginData != null) {
      await p.setString('loginData', jsonEncode(loginData!.toJson()));
    } else {
      await p.remove('loginData');
      await p.remove('baseUrl');
    }
  }
}
