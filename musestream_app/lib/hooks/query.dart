import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:musestream_app/providers/core.dart';

// display query state
class QueryDisplay<T> extends StatelessWidget {
  final QueryHookState q;
  final Widget? Function()? loading;
  final Widget? Function(T)? val;
  final Widget? Function(QueryHookState)? err;

  const QueryDisplay({
    Key? key,
    required this.q,
    this.loading,
    this.val,
    this.err,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (q.isLoading) {
      if (loading == null) {
        return SizedBox(height: 16, width: 16, child: CircularProgressIndicator());
      } else {
        return loading!() ?? SizedBox();
      }
    }
    if (q.error != null && err != null) return err!(q) ?? SizedBox();
    if (q.value != null && val != null) return val!(q.value!) ?? SizedBox();
    return SizedBox();
  }
}

class QueryHookState<T> {
  bool isLoading;

  T? value;
  Object? error;
  Future<void> Function() run;

  String get errMsg {
    if (error is ApiErr?) {
      if (error == null) return 'Unknown error';
      return (error as ApiErr).msg;
    }
    return error.toString();
  }

  QueryHookState(
    this.value,
    this.error,
    this.isLoading,
    this.run,
  );
}

// note: creator must be within callback
QueryHookState<T> useQuery<T>(
  Future<T> Function() creator, {
  final Future<void> Function(T)? onSuccess,
  final Future<void> Function(Object)? onError,
}) {
  final loading = useState(false);
  final resp = useState<T?>(null);
  final err = useState<Object?>(null);

  final run = useCallback(() async {
    loading.value = true;
    resp.value = null;
    err.value = null;
    try {
      resp.value = await creator();
    } catch (e) {
      if (e is ApiErr) {
        print(e.res?.data); // debug print response error
        err.value = e;
        onError?.call(e);
        print(e);
      } else {
        rethrow;
      }
    }
    loading.value = false;
  }, [creator]);

  return QueryHookState(resp.value, err.value, loading.value, run);
}
