import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';

class UserTyped extends HookConsumerWidget {
  final User usr;
  final void Function()? onChange;

  const UserTyped({Key? key, required this.usr, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);
    final type = useState(usr.type);

    // update user type
    final qUpdate = useQuery<void>(
      useCallback(() async {
        await core.handle(core.dio.put('/users/${usr.id}', data: {
          'type': type.value,
        }));
      }, [core, type.value]),
    );

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.amber,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${usr.fullName} (${usr.type})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Radio<String>(
                value: 'student',
                groupValue: type.value,
                onChanged: (v) async {
                  type.value = v ?? 'student';
                  await qUpdate.run();
                  onChange?.call();
                },
              ),
              Radio<String>(
                value: 'teacher',
                groupValue: type.value,
                onChanged: (v) async {
                  type.value = v ?? 'teacher';
                  await qUpdate.run();
                  onChange?.call();
                },
              ),
              Radio<String>(
                value: 'admin',
                groupValue: type.value,
                onChanged: (v) async {
                  type.value = v ?? 'admin';
                  await qUpdate.run();
                  onChange?.call();
                },
              ),
              QueryDisplay(q: qUpdate),
            ],
          ),
        ),
      ),
    );
  }
}
