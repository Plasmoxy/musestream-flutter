import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/auth.dart';

class Repository {
  final AuthStore auth;
  final dio = Dio();

  static final provider = Provider((ref) => Repository(ref.watch(AuthStore.provider)));

  Repository(this.auth) {
    if (auth.token != null) dio.options.headers['authorization'] = 'Bearer ${auth.token}';
    dio.options.baseUrl = 'http://localhost';
  }

  dynamic hello() => dio.get('/');
}
