import 'package:data/infobip_audio/infobip_message_service.dart';
import 'package:data/source/infobip_audio/infobip_message_datasource.dart';

class InfobipMessageDSImpl with InfobipMessageLocalDs {
  final InfobipMessageService _infobipAudioService;

  InfobipMessageDSImpl(this._infobipAudioService);

  @override
  Future<bool> initInfobipMessage(Function(bool) callback) async {
    return await _infobipAudioService.initPlatformState(callback: callback);
  }

  @override
  Future<bool> showChat() async {
    return await _infobipAudioService.showChat();
  }
}
