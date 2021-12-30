import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoKycViewModel extends BasePageViewModel {
  final String agoraAppId = "9bafccfa4cb44f27abf78d7df558d436";
  final String agoraAppCertificate = "99654f32a173466e94ad5dc43f392b82";
  final String channelId = "blinkTest";
  final String tempToken = "99654f32a173466e94ad5dc43f392b82";
  final int uid = 0;
  final String stringUid = "0";

  late final RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  VideoKycViewModel() {
    _initEngine();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(agoraAppId));
    _addAgoraEventHandlers();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print("joinChannelSuccess $uid");
        isJoined = true;
        notifyListeners();
      },
      userJoined: (uid, elapsed) {
        print("userJoined $uid");
        remoteUid.add(uid);
        notifyListeners();
      },
      userOffline: (uid, reason) {
        print("userOffline $uid");
        remoteUid.removeWhere((element) => element == uid);
        notifyListeners();
      },
      leaveChannel: (stats) {
        isJoined = false;
        remoteUid.clear();
        notifyListeners();
      },
    ));
  }

  joinAgoraChannel() async {
    if (Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(tempToken, channelId, null, uid);
    notifyListeners();
  }

  leaveAgoraChannel() async {
    await _engine.leaveChannel();
    notifyListeners();
  }

  switchAgoraCamera() {
    _engine.switchCamera().then((value) {
      switchCamera = !switchCamera;
      notifyListeners();
    }).catchError((err) {
      print('switchCamera $err');
    });
  }

  switchAgoraRender() {
    switchRender = !switchRender;
    remoteUid = List.of(remoteUid.reversed);
    notifyListeners();
  }

  @override
  void dispose() {
    _engine.destroy();
    super.dispose();
  }
}
