import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/app_flyer/init_app_flyer_sdk.dart';
import 'package:domain/usecase/app_flyer/log_app_flyers_events.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[InitAppFlyerSDKUseCase] provider
final initiAppFlyerSDKProvider = Provider.autoDispose<InitAppFlyerSDKUseCase>(
    (ref) => InitAppFlyerSDKUseCase(ref.read(appFlyerRepositoryProvider)));

///[LogAppFlyerSDKEventsUseCase] provider
final logAppFlyerEventUseCaseProvider = Provider.autoDispose<LogAppFlyerSDKEventsUseCase>(
    (ref) => LogAppFlyerSDKEventsUseCase(ref.read(appFlyerRepositoryProvider)));
