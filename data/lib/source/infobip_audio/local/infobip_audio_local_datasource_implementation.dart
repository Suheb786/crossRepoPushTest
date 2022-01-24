import 'package:data/infobip_audio/infobip_audio_service.dart';
import 'package:data/source/infobip_audio/infobip_audio_datasource.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';

class InfobipAudioDSImpl with InfobipAudioLocalDs {
  final InfoBipAudioService _infobipAudioService;

  InfobipAudioDSImpl(this._infobipAudioService);

  @override
  Future<bool> initInfobipAudio(Function(InfobipCallStatusEnum) callback) {
    return _infobipAudioService.initPlugin(callback: callback);
  }

  @override
  Future<String> obtainToken(ObtainToken parameter) async {
    return await _infobipAudioService.obtainToken(parameter: parameter);
  }

  @override
  Future<bool> establishCall() async {
    return await _infobipAudioService.call();
  }

  @override
  Future<bool> toggleMute() async {
    return await _infobipAudioService.mute();
  }

  @override
  Future<bool> toggleSpeaker() async {
    return await _infobipAudioService.toggleSpeaker();
  }

  @override
  Future<bool> callHangUp() async {
    return await _infobipAudioService.callHangUp();
  }

  @override
  Future<int> getCallDuration() async {
    return await _infobipAudioService.getCallDuration();
  }
}
