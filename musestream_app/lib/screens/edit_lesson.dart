import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/utils/util.dart';

class EditLessonScreen extends HookConsumerWidget {
  // pass if edit, otherwise create
  final Lesson? toEdit;
  final int classId;
  final int studentId;

  const EditLessonScreen({Key? key, this.toEdit, required this.classId, required this.studentId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final notes = useTextEditingController(text: toEdit?.notes);
    final start = useState<DateTime>(toEdit?.start ?? DateTime.now());
    final end = useState<DateTime>(toEdit?.end ?? DateTime.now().add(Duration(hours: 1)));
    final form = useMemoized(() => GlobalKey<FormState>());

    final queryUpdate = useQuery<void>(
      useCallback(() async {
        if (toEdit == null) {
          print('/classes/$classId/students/$studentId/lessons');
          // create
          await core.handle(core.dio.post('/classes/$classId/students/$studentId/lessons', data: {
            'notes': notes.text,
            'start': start.value.toIso8601String(),
            'end': end.value.toIso8601String(),
          }));
        } else {
          // update
          await core.handle(core.dio.put('/lessons/${toEdit!.id}', data: {
            'notes': notes.text,
            'start': start.value.toIso8601String(),
            'end': end.value.toIso8601String(),
          }));
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
        title: Text(toEdit == null ? 'New lesson' : 'Edit lesson'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    'Start',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final d = await showDatePicker(context: context, initialDate: start.value, firstDate: DateTime(2022, 4, 19), lastDate: DateTime(2050, 4, 19));

                      final t = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (d != null && t != null) {
                        start.value = DateTime(d.year, d.month, d.day, t.hour, t.minute);
                      }
                    },
                    icon: Icon(Icons.edit),
                    label: Text(formatDate(start.value)),
                  ),
                  SizedBox(height: 8),
                  Text(end.value.toString()),
                  Text(
                    'End',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final d = await showDatePicker(context: context, initialDate: end.value, firstDate: DateTime(2022, 4, 19), lastDate: DateTime(2050, 4, 19));

                      final t = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (d != null && t != null) {
                        end.value = DateTime(d.year, d.month, d.day, t.hour, t.minute);
                      }
                    },
                    icon: Icon(Icons.edit),
                    label: Text(formatDate(end.value)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Notes',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Lesson notes'),
                    ),
                    controller: notes,
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
