import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/utility/utility_usecase_provider.dart';
import 'package:neo_bank/feature/splash/splash_page_model.dart';

final splashViewModelProvider =
    ChangeNotifierProvider.autoDispose<SplashViewModel>(
  (ref) => SplashViewModel(ref.read(checkDeviceCompatibilityUseCaseProvider)),
);
