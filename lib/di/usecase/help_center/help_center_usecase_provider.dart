import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/infobip_audio/call_duration_usecase.dart';
import 'package:domain/usecase/infobip_audio/establish_call_usecase.dart';
import 'package:domain/usecase/infobip_audio/hangup_call_usecase.dart';
import 'package:domain/usecase/infobip_audio/init_infobip_audio_usecase.dart';
import 'package:domain/usecase/infobip_audio/mute_unmute_usecase.dart';
import 'package:domain/usecase/infobip_audio/obtain_token_usecase.dart';
import 'package:domain/usecase/infobip_audio/speaker_on_off_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[InfobipAudioPluginUseCase] provider
final infobipAudioPluginUseCaseProvider =
    Provider.autoDispose<InfobipAudioPluginUseCase>(
  (ref) => InfobipAudioPluginUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[ObtainTokenUseCase] provider
final obtainTokenUseCaseProvider = Provider.autoDispose<ObtainTokenUseCase>(
  (ref) => ObtainTokenUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[EstablishCallUseCase] provider
final establishCallUseCaseProvider = Provider.autoDispose<EstablishCallUseCase>(
  (ref) => EstablishCallUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[MuteUnMuteUseCase] provider
final muteUnMuteUseCaseProvider = Provider.autoDispose<MuteUnMuteUseCase>(
  (ref) => MuteUnMuteUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[MuteUnMuteUseCase] provider
final hangupCallUseCaseProvider = Provider.autoDispose<HangupCallUseCase>(
  (ref) => HangupCallUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[MuteUnMuteUseCase] provider
final speakerOnOffUseCaseProvider = Provider.autoDispose<SpeakerOnOffUseCase>(
  (ref) => SpeakerOnOffUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[CallDurationUseCase] provider
final callDurationUseCaseProvider = Provider.autoDispose<CallDurationUseCase>(
  (ref) => CallDurationUseCase(ref.read(helpCenterRepositoryProvider)),
);
