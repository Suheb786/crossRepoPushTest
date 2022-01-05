import 'package:infobip_plugin/infobip_plugin.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoBipAudioService {
  final InfobipPlugin _infobipPlugin;

  InfoBipAudioService(this._infobipPlugin);

  Future<bool> initPlugin(
      {required String applicationId,
      required String appKey,
      required String baseUrl,
      required Function(InfobipCallStatusEnum) callback}) async {
    var result = await _infobipPlugin.init(
        appKey: appKey,
        applicationId: applicationId,
        baseUrl: baseUrl,
        callStatus: (String status) {
          print(status);
          callback(status.fromCallStatusValue());
        });
    return result!;
  }

  ///
  /// This method used for get your token with
  ///
  Future<String> obtainToken(
      {required String identity, required String displayName}) async {
    try {
      var tokenDetail = await _infobipPlugin.getToken(
          identity: identity, displayName: displayName);
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
      openAppSettings();
    }
  }

  ///
  /// This method is used to call agent
  ///
  Future<bool> call() async {
    try {
      return requestPermission().then((value) async {
        return await _infobipPlugin.callConversations();
      });
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to mute or unmute call
  ///
  void mute() async {
    try {
      await _infobipPlugin.muteUnMute();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to on off phone speaker
  ///
  void toggleSpeaker() async {
    try {
      await _infobipPlugin.toggleSpeaker();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get current call duration in seconds
  ///
  void getCallDuration() async {
    try {
      await _infobipPlugin.getCallDuration();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get call establish time
  ///
  void getCallEstablishTime() async {
    try {
      await _infobipPlugin.getCallEstablishTime();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get call start time
  ///
  void getCallStartTime() async {
    try {
      await _infobipPlugin.getCallStartTime();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to get call end time
  ///
  void getCallendTime() async {
    try {
      await _infobipPlugin.getEndTime();
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to hangup call
  ///
  void callHangUp() async {
    try {
      await _infobipPlugin.hangUpCall();
    } catch (e) {
      rethrow;
    }
  }
}
