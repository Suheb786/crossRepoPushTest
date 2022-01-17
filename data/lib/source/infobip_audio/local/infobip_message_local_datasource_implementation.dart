import 'package:data/infobip_audio/infobip_message_service.dart';
import 'package:data/source/infobip_audio/infobip_message_datasource.dart';

class InfobipMessageDSImpl with InfobipMessageLocalDs {
  final InfobipMessageService _infobipAudioService;

  InfobipMessageDSImpl(this._infobipAudioService);

  @override
  Future<bool> initInfobipMessage() async {
    return await _infobipAudioService.initPlatformState();
  }

  @override
  Future<bool> showChat() async {
    return await _infobipAudioService.showChat();
  }
}
