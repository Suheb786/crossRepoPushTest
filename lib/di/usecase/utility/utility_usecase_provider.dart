import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/utility/check_device_compatibility_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CheckDeviceCompatibilityUsecase] provider
final checkDeviceCompatibilityUseCaseProvider =
    Provider.autoDispose<CheckDeviceCompatibilityUsecase>(
  (ref) => CheckDeviceCompatibilityUsecase(ref.read(utilityRepositoryProvider)),
);
