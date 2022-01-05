import 'package:data/infobip_audio/infobip_audio_service.dart';
import 'package:data/source/infobip_audio/infobip_audio_datasource.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';

class InfobipAudioDSImpl with InfobipAudioLocalDs {
  final InfoBipAudioService _infobipAudioService;

  InfobipAudioDSImpl(this._infobipAudioService);

  @override
  Future<bool> initInfobipAudio(Function(InfobipCallStatusEnum) callback) {
    return _infobipAudioService.initPlugin(callback: callback);
  }

  @override
  Future<String> obtainToken(Map<String, String> parameter) async {
    return await _infobipAudioService.obtainToken(parameter: parameter);
  }

  @override
  Future<bool> establishCall() async {
    return await _infobipAudioService.call();
  }
}
