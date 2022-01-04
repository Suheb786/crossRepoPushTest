import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/infobip_audio/init_infobip_audio_usecase.dart';
import 'package:domain/usecase/infobip_audio/obtain_token_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[InfobipAudioPluginUseCase] provider
final infobipAudioPluginUseCaseProvider =
Provider.autoDispose<InfobipAudioPluginUseCase>(
      (ref) => InfobipAudioPluginUseCase(ref.read(helpCenterRepositoryProvider)),
);

///[ObtainTokenUseCase] provider
final obtainTokenUseCaseProvider =
Provider.autoDispose<ObtainTokenUseCase>(
      (ref) => ObtainTokenUseCase(ref.read(helpCenterRepositoryProvider)),
);
