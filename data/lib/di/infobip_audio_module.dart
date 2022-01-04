import 'package:data/infobip_audio/infobip_audio_service.dart';
import 'package:infobip_plugin/infobip_plugin.dart';
import 'package:riverpod/riverpod.dart';

final infobipAudioProvider = Provider<InfobipPlugin>(
      (ref) => InfobipPlugin(),
);

final infobipAudioServiceProvider = Provider<InfoBipAudioService>(
      (ref) =>
          InfoBipAudioService(
        ref.read(infobipAudioProvider),
      ),
);