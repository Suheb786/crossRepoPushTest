import 'package:infobip_plugin/infobip_plugin.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';

class InfoBipAudioService {
  final InfobipPlugin _infobipPlugin;

  InfoBipAudioService(this._infobipPlugin);

  Future<bool> initPlugin(
      {required Function(InfobipCallStatusEnum) callback}) async {
    var result = await _infobipPlugin.init(
        applicationId: "75154e24-1e99-48e4-a25d-9f561df4d101",
        appKey:
            "d48f97a07a5828761b1b8abe2976a24a-f66e3aa6-ff53-4387-a45e-0f52bdc89a11",
        baseUrl: "https://gyw5rw.api.infobip.com",
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
    // var parameter = {"identity": 'Alice_Test', "displayName": 'Alice Test'};
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
