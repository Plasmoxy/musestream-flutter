import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/repository.dart';

class AuthStore extends ChangeNotifier {
  String? token;
  int count = 0;

  AuthStore();

  static final provider = ChangeNotifierProvider((ref) => AuthStore());

  static final login = FutureProvider.autoDispose.family<dynamic, dynamic>((ref, body) async {
    final resp = await ref.watch(Repository.provider).dio.post('/login', data: body);
    final auth = ref.watch(provider);
    auth.token = resp.data['token'];
    auth.notifyListeners();
  });

  void inc() {
    count++;
    notifyListeners();
  }

  void setToken(String? t) {
    token = t;
    notifyListeners();
  }
}
