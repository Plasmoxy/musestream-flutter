import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/utils/util.dart';

class NewClassRequestScreen extends HookConsumerWidget {
  final int classId;

  const NewClassRequestScreen({Key? key, required this.classId}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final msgCtrl = useTextEditingController();
    final form = useMemoized(() => GlobalKey<FormState>());

    final qClass = useQuery(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<dynamic>('/classes/$classId'));
        return Class.fromJson(resp.data);
      }, [core]),
      activate: true,
    );

    final qCreateRequest = useQuery(
      useCallback(() async {
        await core.handle(core.dio.post<dynamic>('/classes/$classId/requests', data: {
          'message': msgCtrl.text,
        }));
      }, [core]),
    );

    final submit = useCallback(() {
      if (form.currentState?.validate() ?? false) {
        qCreateRequest.run();
      }
    }, [form]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a class'),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: QueryDisplay<Class>(
            q: qClass,
            val: (cls) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // class rendering
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(36),
                      child: Row(
                        children: [
                          Icon(Icons.school, size: 32),
                          SizedBox(width: 32),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cls!.title,
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.left, // for example
                                ),
                                Text(
                                  'with ' + (cls.teacher?.fullName ?? ''),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('• Instrument: ' + cls.instrument),
                                Text('• Description: ' + cls.description),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // lessons
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 16),
                    Text(cls.description),
                    SizedBox(height: 16),
                    Text(
                      'Message for teacher',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: msgCtrl,
                      decoration: InputDecoration(
                        label: Text('Message'),
                        border: OutlineInputBorder(),
                      ),
                      validator: notEmpty,
                    ),
                    SizedBox(height: 16),
                    QueryDisplay<void>(
                      q: qCreateRequest,
                      val: (v) => Text(
                        'Request sent !',
                        style: tsSucc,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: Text(
                            'Ask teacher to join',
                          ),
                          onPressed: submit,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
