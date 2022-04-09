import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/services/signaling.dart';
import 'package:musestream_app/widgets/drawer.dart';

class RTCTestScreen extends HookConsumerWidget {
  const RTCTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = useFuture(useMemoized(
      () => FirebaseFirestore.instance.collection('klobasy').get(),
    ));

    final signaling = useMemoized(() => Signaling());
    final _localRenderer = useMemoized(() => RTCVideoRenderer());
    final _remoteRenderer = useMemoized(() => RTCVideoRenderer());
    final roomId = useState<String?>(null);
    final textEditingController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('RTC Test Screen')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kolbasy request paci sa:'),
            if (snapshot.hasData)
              Text(snapshot.data!.docs
                  .map((d) => {
                        'id': d.id,
                        ...d.data(),
                      })
                  .toString()),
            if (snapshot.hasError) Text(snapshot.error!.toString()),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                signaling.openUserMedia(_localRenderer, _remoteRenderer);
              },
              child: Text("Open camera & microphone"),
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                roomId.value = await signaling.createRoom(_remoteRenderer);
                textEditingController.text = roomId.value!;
              },
              child: Text("Create room"),
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {
                // Add roomId
                signaling.joinRoom(
                  textEditingController.text,
                  _remoteRenderer,
                );
              },
              child: Text("Join room"),
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {
                signaling.hangUp(_localRenderer);
              },
              child: Text("Hangup"),
            ),
            SizedBox(height: 8),
            Text('Local'),
            Container(
              width: 200,
              height: 200,
              child: RTCVideoView(_localRenderer, mirror: true),
            ),
            Text('Remote'),
            Container(
              width: 200,
              height: 200,
              child: RTCVideoView(_remoteRenderer, mirror: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Join the following Room: "),
                  Flexible(
                    child: TextFormField(
                      controller: textEditingController,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
