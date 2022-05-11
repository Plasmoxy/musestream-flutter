import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/utils/util.dart';

// display query state
class QueryDisplay<T> extends HookConsumerWidget {
  final QueryHookState<T> q;
  final Widget? Function()? loading;
  final Widget? Function(T?)? val;
  final Widget? Function(QueryHookState)? err;

  const QueryDisplay({
    Key? key,
    required this.q,
    this.loading,
    this.val,
    this.err,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    // do not show inactive queries
    if (!q.isActive) return SizedBox();

    // default loading indicator
    if (q.isLoading) {
      if (loading == null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(18),
              child: SizedBox(height: 18, width: 18, child: CircularProgressIndicator()),
            ),
          ],
        );
      } else {
        return loading!() ?? SizedBox();
      }
    }

    // if error then error
    if (q.error != null) {
      if (err != null) {
        return err!(q) ?? SizedBox();
      } else {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // DO NOT DISPLAY CONNECTION ERROR WHEN OFFLINE, WE KNOW THAT OFC - or do we ?
              // if (core.online || q.errMsg != 'Connection error')
              Text(
                q.errMsg,
                style: tsErr,
              ),
            ],
          ),
        );
      }
    }

    // otherwise display result
    return val?.call(q.value) ?? SizedBox();
  }
}

class QueryHookState<T> {
  bool isLoading;
  bool isActive;

  T? value;
  Object? error;
  Future<void> Function() run;

  String get errMsg {
    if (error != null) {
      // grab api error message first
      if (error is ApiErr) {
        final e = (error as ApiErr);
        return e.msg;
      }
      // otherwise grab serverside message if supplied
      if (error is DioError) {
        final e = error as DioError;

        if (e.response?.data?['message'] != null) {
          return e.response?.data?['message'];
        }
      }
    }
    return 'Unknown error occured, please see logs.';
  }

  QueryHookState(
    this.value,
    this.error,
    this.isLoading,
    this.isActive,
    this.run,
  );
}

// note: creator must be within callback
QueryHookState<T> useQuery<T>(
  Future<T> Function() creator, {
  final Future<void> Function(T?)? onSuccess,
  final Future<void> Function(Object)? onError,
  bool activate = false,
}) {
  final active = useState(false);
  final loading = useState(false);
  final resp = useState<T?>(null);
  final err = useState<Object?>(null);

  final run = useCallback(() async {
    active.value = true;
    loading.value = true;
    resp.value = null;
    err.value = null;
    try {
      resp.value = await creator();
      onSuccess?.call(resp.value);
    } catch (e) {
      err.value = e;
      onError?.call(e);

      print('----- QUERY ERROR -----');
      if (e is DioError) {
        print(e.response?.data);
      }
      print('-----------------------');
      print(e);
    }
    loading.value = false;
  }, [creator]);

  // trigger first run if activated
  useEffect(() {
    if (activate) run();
    return () {};
  }, [activate]);

  return QueryHookState(resp.value, err.value, loading.value, active.value, run);
}
