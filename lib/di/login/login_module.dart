import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/bill_payments/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/device_change/device_change_usecase.dart';
import 'package:neo_bank/di/usecase/help_center/help_center_usecase_provider.dart';
import 'package:neo_bank/di/usecase/kyc/kyc_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/onboarding/login_landing_page/login_landing_page_view_model.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';

final loginViewModelProvider = ChangeNotifierProvider.autoDispose<LoginViewModel>(
  (ref) => LoginViewModel(ref.read(loginUseCaseProvider), ref.read(checkKycStatusUseCaseProvider),
      ref.read(sendOtpTokenDeviceChangeUseCaseProvider)),
);
final loginLandingViewModelProvider = ChangeNotifierProvider.autoDispose<LoginLandingPageViewModel>(
  (ref) => LoginLandingPageViewModel(
    ref.read(checkKycStatusUseCaseProvider),
    ref.read(androidLoginUseCaseProvider),
    ref.read(checkBioMetricSupportUseCaseProvider),
    ref.read(authenticateBioMetricUseCaseProvider),
    ref.read(checkVersionUpdateUseCaseProvider),
    ref.read(currentUserUseCaseProvider),
    ref.read(infobipMessagePluginUseCaseProvider),
  ),
);
