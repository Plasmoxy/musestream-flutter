import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:musestream_app/providers/transactions.dart';
import 'package:musestream_app/utils/util.dart';
import 'package:musestream_app/widgets/netstatus.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassFilesScreen extends HookConsumerWidget {
  final int classId;

  const ClassFilesScreen({Key? key, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final transactions = ref.watch(Transactions.provider);
    final toUpload = useRef<File?>(null);

    final qFiles = useQuery<List<ClassFile>>(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<List<dynamic>>('/classfiles/$classId'));
        return resp.data!.map((j) => ClassFile.fromJson(j)).toList();
      }, [core]),
      activate: core.online,
      deps: [transactions.running],
    );

    final qUpload = useQuery<void>(
      useCallback(() async {
        if (toUpload.value == null) return;
        final fileName = toUpload.value!.path.split('/').last;
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(toUpload.value!.path, filename: fileName),
        });
        await transactions.make(() => core.handle(core.dio.post('/classfiles/$classId', data: formData)));
      }, [core]),
      onSuccess: (v) async {
        qFiles.run();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Class files"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              NetStatus(),
              QueryDisplay(q: qFiles),
              if (qFiles.value != null)
                ...qFiles.value!.map(
                  (f) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.amber,
                      margin: EdgeInsets.all(8),
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(children: [
                            Expanded(child: Text(f.title)),
                            IconButton(
                              icon: Icon(
                                Icons.download,
                              ),
                              onPressed: () async {
                                launch(core.dio.options.baseUrl + f.path);
                              },
                            ),
                          ])),
                    ),
                  ),
                ),
              QueryDisplay(
                q: qUpload,
                val: (void t) => Text('Done.'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: core.loginData?.user.type == 'teacher'
          ? FloatingActionButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                );

                if (result != null) {
                  toUpload.value = File(result.files.single.path!);
                  qUpload.run();
                }
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
