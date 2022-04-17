import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QueryHookState<T> {
  bool loading;

  Response<T>? resp;
  T? get data => resp?.data;
  DioError? err;
  void Function() run;

  QueryHookState(
    this.resp,
    this.err,
    this.loading,
    this.run,
  );
}

// note: creator must be within callback
QueryHookState<T> useQuery<T>(Future<Response<T>> Function() creator) {
  final loading = useState(false);
  final resp = useState<Response<T>?>(null);
  final err = useState<DioError?>(null);

  final run = useCallback(() async {
    loading.value = true;
    try {
      resp.value = await creator();
    } catch (e) {
      if (e is DioError) {
        err.value = e;
      } else {
        loading.value = false;
        rethrow;
      }
    }
    loading.value = false;
  }, [creator]);

  return QueryHookState(resp.value, err.value, loading.value, run);
}
