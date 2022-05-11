import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/providers/transactions.dart';
import 'package:musestream_app/utils/util.dart';

class EditClassScreen extends HookConsumerWidget {
  // pass if edit, otherwise create
  final Class? toEdit;

  const EditClassScreen({Key? key, this.toEdit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final transactions = ref.watch(Transactions.provider);
    final titleCtrl = useTextEditingController(text: toEdit?.title);
    final descCtrl = useTextEditingController(text: toEdit?.description);
    final instrCtrl = useTextEditingController(text: toEdit?.instrument);
    final form = useMemoized(() => GlobalKey<FormState>());

    final queryUpdate = useQuery<void>(
      useCallback(() async {
        if (toEdit == null) {
          transactions.make(() => core.handle(core.dio.post('/classes', data: {
                'title': titleCtrl.text,
                'description': descCtrl.text,
                'instrument': instrCtrl.text,
              })));
        } else {
          transactions.make(() => core.handle(core.dio.put('/classes/${toEdit!.id}', data: {
                'title': titleCtrl.text,
                'description': descCtrl.text,
                'instrument': instrCtrl.text,
              })));
        }
      }, [core]),
      onSuccess: (v) async {
        Navigator.of(context).pop();
      },
    );

    final submit = useCallback(() {
      if (form.currentState?.validate() ?? false) {
        queryUpdate.run();
      }
    }, [form]);

    return Scaffold(
      appBar: AppBar(
        title: Text(toEdit == null ? 'New class' : 'Edit class'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Title'),
                    ),
                    controller: titleCtrl,
                    validator: notEmpty,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Description'),
                    ),
                    controller: descCtrl,
                    validator: notEmpty,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Instrument'),
                    ),
                    controller: instrCtrl,
                    validator: notEmpty,
                  ),
                  SizedBox(height: 16),
                  QueryDisplay<void>(
                    q: queryUpdate,
                    val: (v) => Text('Class saved!'),
                    err: (q) => Text(q.errMsg, style: tsErr),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        child: Text(
                          'Save',
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
    );
  }
}
