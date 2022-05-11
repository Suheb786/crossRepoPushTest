import 'package:data/helper/key_helper.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';
import 'package:infobip_plugin/infobip_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoBipAudioService {
  final InfobipPlugin _infobipPlugin;

  InfoBipAudioService(this._infobipPlugin);

  Future<bool> initPlugin(
      {required Function(InfobipCallStatusEnum) callback}) async {
    var result = await _infobipPlugin.init(
        applicationId: "75154e24-1e99-48e4-a25d-9f561df4d101",
        appKey: KeyHelper.INFOBIP_APP_KEY,
        // "d4e7fbd8004b1d727d98fa3cdcc69c07-9351b520-0a0e-4a81-904e-a9cb97ff003c", // Developer
        // "8435fe9bc0853a9cf2c01336cbf069f3-46b5b7fa-9678-49f3-9d8b-143a9799f564", // Production
        baseUrl: "https://wpx36d.api.infobip.com",
        callStatus: (String status) {
          print(status);
          callback(status.fromCallStatusValue());
        });
    return result!;
  }

  ///
  /// This method used for get your token with
  ///
  Future<String> obtainToken({required ObtainToken parameter}) async {
    try {
      var tokenDetail =
          await _infobipPlugin.getToken(parameter: parameter.toJson());
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
    print(status);
    if (status == PermissionStatus.permanentlyDenied) {
      final status = await Permission.microphone.request();
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
  Future<bool> mute() async {
    try {
      var muteStatus = await _infobipPlugin.muteUnMute();
      print('--------' + muteStatus.toString());
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
      var speakerStatus = await _infobipPlugin.toggleSpeaker();
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
      var callDuration = await _infobipPlugin.getCallDuration();
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
      var result = await _infobipPlugin.hangUpCall();
      print("HANGUP FROM SERVICE " + result.toString());
      return result!;
    } catch (e) {
      rethrow;
    }
  }
}
