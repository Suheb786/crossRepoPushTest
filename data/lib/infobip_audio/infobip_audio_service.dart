import 'package:infobip_plugin/infobip_plugin.dart';

class InfoBipAudioService {
  final InfobipPlugin _infobipPlugin;

  InfoBipAudioService(this._infobipPlugin);

  Future<bool> initPlugin(
      {required String applicationId,
      required String appKey,
      required String baseUrl,
      required Function(String) callback}) async {
    var result = await _infobipPlugin.init(
        appKey: appKey,
        applicationId: applicationId,
        baseUrl: baseUrl,
        callStatus: (status) {
          print(status);
          callback(status);
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
      print("TOKEN ::: $tokenDetail");

      return tokenDetail!;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// This method is used to call agent
  ///
  Future<void> call() async {
    try {
      await _infobipPlugin.callConversations();
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
