import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/notify/notify_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[NotifyUseCase] provider
final notifyUseCaseProvider = Provider.autoDispose<NotifyUseCase>(
      (ref) => NotifyUseCase(ref.read(userRepoProvider)),
);
