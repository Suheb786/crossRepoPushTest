import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page_model.dart';

final onBoardingViewModelProvider = ChangeNotifierProvider.autoDispose<OnBoardingViewModel>(
  (ref) => OnBoardingViewModel(ref.read(checkVersionUpdateUseCaseProvider)),
);
