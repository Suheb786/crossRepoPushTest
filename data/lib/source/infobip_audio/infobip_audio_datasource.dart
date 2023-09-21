import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';

abstract class InfobipAudioLocalDs {
  Future<bool> initInfobipAudio(Function(InfobipCallStatusEnum) callback);

  Future<bool> listenCallStatus(Function(InfobipCallStatusEnum) callback);

  Future<String> obtainToken(ObtainToken parameter);

  Future<bool> establishCall(String token);

  Future<bool> toggleMute();

  Future<bool> toggleSpeaker();

  Future<bool> callHangUp();

  Future<int> getCallDuration();
}
