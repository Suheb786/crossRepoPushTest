import 'package:domain/constants/enum/infobip_call_status_enum.dart';

abstract class InfobipAudioLocalDs {
  Future<bool> initInfobipAudio(Function(InfobipCallStatusEnum) callback);

  Future<String> obtainToken(Map<String, String> parameter);

  Future<bool> establishCall();

  Future<bool> toggleMute();

  Future<bool> toggleSpeaker();

  Future<bool> callHangUp();

  Future<int> getCallDuration();
}
