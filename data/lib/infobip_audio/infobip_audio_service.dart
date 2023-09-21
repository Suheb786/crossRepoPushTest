import 'dart:async';

import 'package:data/helper/key_helper.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';
import 'package:infobip_plugin/infobipplugin.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoBipAudioService {
  final InfoBip _infobipPlugin;

  InfoBipAudioService(this._infobipPlugin);

  Future<bool> initPlugin({required Function(InfobipCallStatusEnum) callback}) async {
    var result = await _infobipPlugin.sdkInit(
        applicationId: "default",
        appKey: 'f0004048eeb567f17f2a2e5732864489-31202bf5-693e-4a38-85e2-5974f5e93640',
        baseUrl: "https://zjyln2.api.infobip.com",
        callStatus: (String status) {
          callback(status.fromCallStatusValue());
        });
    return result != null;
  }

  // StreamController<String> _callStatusController = StreamController<String>.broadcast();

  // Stream<String> getCallStatusStream() => _callStatusController.stream;
  //_callStatusController.add(event ?? '');

  listenCallStatus({required Function(InfobipCallStatusEnum) onCallBack}) {
    _infobipPlugin.listenCallStatus.listen((event) {
      print("service $event");
      if (event != null) {
        onCallBack(event.fromCallStatusValue());
      }
    });
    return Future.value(true);
  }

  ///
  /// This method used for get your token with
  ///
  Future<String> obtainToken({required ObtainToken parameter}) async {
    try {
      var tokenDetail = await _infobipPlugin.getToken(parameter: parameter.toJson());
      return tokenDetail!;
    } catch (e) {
      rethrow;
    }
  }

  ///
  ///Add recod audio permission
  ///
  Future<void> requestPermission() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.permanentlyDenied) {
      final status = await Permission.microphone.request();
    }
  }

  ///
  /// This method is used to call agent
  ///
  Future<bool> call(String token) async {
    try {
      return requestPermission().then((value) async {
        String result = await _infobipPlugin.callDial(token: token);
        return result != null;
      });
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to mute or unmute call
  ///
  Future<bool> mute() async {
    try {
      var muteStatus = await _infobipPlugin.muteUnmute();
      return muteStatus!;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to on off phone speaker
  ///
  Future<bool> toggleSpeaker() async {
    try {
      var speakerStatus = await _infobipPlugin.speakerPhone();
      return speakerStatus!;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get current call duration in seconds
  ///
  Future<int> getCallDuration() async {
    try {
      var callDuration = await _infobipPlugin.callDuration();
      return callDuration!;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to hangup call
  ///
  Future<bool> callHangUp() async {
    try {
      var result = await _infobipPlugin.callHang();
      return result!;
    } catch (e) {
      rethrow;
    }
  }
}
