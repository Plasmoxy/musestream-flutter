import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musestream_app/hooks/query.dart';
import 'package:musestream_app/models/models.dart';
import 'package:musestream_app/providers/core.dart';
import 'package:musestream_app/services/signaling.dart';

class CallScreen extends HookConsumerWidget {
  final int lessonId;

  const CallScreen({
    Key? key,
    required this.lessonId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final core = ref.watch(Core.provider);

    // listen to connection state, fixes video update on changes
    final connectionState = useState<RTCPeerConnectionState?>(null);
    final onConnChange = useCallback((RTCPeerConnectionState s) {
      connectionState.value = s;
    }, []);

    // construct rtc signaling and renderers
    final signaling = useMemoized(() => Signaling(
          onConnectionStateChange: onConnChange,
        ));
    final _localRenderer = useMemoized(() => RTCVideoRenderer());
    final _remoteRenderer = useMemoized(() => RTCVideoRenderer());

    // initialize call method
    final initialize = useCallback((String? roomId) async {
      print('== initialzing call ... ==');

      await signaling.openUserMedia(_localRenderer, _remoteRenderer);

      if (core.user?.type == 'teacher') {
        final newRoomId = await signaling.createRoom(_remoteRenderer);
        await core.handle(core.dio.put('/lessons/$lessonId', data: {
          'roomId': newRoomId,
        }));
        print('=== ROOM CREATED $newRoomId ===');
      }

      if (core.user?.type == 'student' && roomId != null) {
        signaling.joinRoom(
          roomId,
          _remoteRenderer,
        );
        print('=== ROOM JOINED: $roomId ===');
      }

      print('== initialize call done ==');
    }, [core]);

    // lesson query for room id
    final qLesson = useQuery<Lesson>(
      useCallback(() async {
        final resp = await core.handle(core.dio.get<dynamic>('/lessons/$lessonId'));
        return Lesson.fromJson(resp.data);
      }, [core, lessonId]),
      activate: true,
      onSuccess: (l) => initialize(l?.roomId),
    );

    // disposing hook
    useEffect(() {
      return () async {
        print('=== HANGING UP AND DISPOSING ===');
        await signaling.hangUp(_localRenderer);
        _localRenderer.dispose();
        _remoteRenderer.dispose();

        core.handle(core.dio.put('/lessons/$lessonId', data: {
          'roomId': null,
        }));
      };
    }, [core]);

    return Scaffold(
      appBar: AppBar(
        title: Text('WebRTC call'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: RTCVideoView(
                    _remoteRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: RTCVideoView(
              _localRenderer,
              mirror: true,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
          SizedBox(height: 16),
          QueryDisplay(q: qLesson),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: (connectionState.value == RTCPeerConnectionState.RTCPeerConnectionStateClosed)
                ? Text('Connection: Cloased')
                : (connectionState.value == RTCPeerConnectionState.RTCPeerConnectionStateConnected)
                    ? Text('Connection: Connected')
                    : (connectionState.value == RTCPeerConnectionState.RTCPeerConnectionStateConnecting)
                        ? Text('Connection: Connecting')
                        : (connectionState.value == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected)
                            ? Text('Connection: Disconnected')
                            : (connectionState.value == RTCPeerConnectionState.RTCPeerConnectionStateFailed)
                                ? Text('Connection: Failed')
                                : (connectionState.value == RTCPeerConnectionState.RTCPeerConnectionStateNew)
                                    ? Text('Connection: New')
                                    : Text('Connection: Peer not connected'),
          ),
        ],
      ),
    );
  }
}
