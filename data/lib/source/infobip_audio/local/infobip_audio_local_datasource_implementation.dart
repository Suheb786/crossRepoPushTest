import 'package:data/infobip_audio/infobip_audio_service.dart';
import 'package:data/source/infobip_audio/infobip_audio_datasource.dart';

class InfobipAudioDSImpl with InfobipAudioDS {
  final InfoBipAudioService _infobipAudioService;

  InfobipAudioDSImpl(this._infobipAudioService);

  @override
  Future<bool> initInfobipAudio(
      String applicationId, String appKey, String baseUrl,Function(String) callback) {
    return _infobipAudioService.initPlugin(
      appKey: appKey,
      applicationId: applicationId,
      baseUrl: baseUrl,
      callback: callback
    );
  }

  @override
  Future<String> obtainToken(String identity, String displayName) async {
    return await _infobipAudioService.obtainToken(
      identity: identity,
      displayName: displayName,
    );
  }
}
