import 'package:domain/constants/enum/infobip_call_status_enum.dart';

abstract class InfobipAudioDS {
  Future<bool> initInfobipAudio(String applicationId, String appKey,
      String baseUrl, Function(InfobipCallStatusEnum) callback);

  Future<String> obtainToken(String identity, String displayName);

  Future<bool> establishCall();
}
