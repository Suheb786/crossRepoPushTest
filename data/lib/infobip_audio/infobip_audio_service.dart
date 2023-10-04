import 'dart:async';

import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';
import 'package:infobipplugin/infobipplugin.dart';
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
    return result;
  }

  /*applicationId: "75154e24-1e99-48e4-a25d-9f561df4d101",
  appKey: KeyHelper.INFOBIP_APP_KEY,
  baseUrl: "https://wpx36d.api.infobip.com",
*/

  ///
  /// This method used for get your token with
  ///
  Future<String> obtainToken({required ObtainToken parameter}) async {
    try {
      parameter.applicationId = 'default';
      parameter.baseUrl = 'https://zjyln2.api.infobip.com';
      parameter.appKey = 'f0004048eeb567f17f2a2e5732864489-31202bf5-693e-4a38-85e2-5974f5e93640';
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
        bool result = await _infobipPlugin.callDial(token: token);
        return result;
      });
    } catch (e) {
      return false;
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
