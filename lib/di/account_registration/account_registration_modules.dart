import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account_registration/account_regisration_usecase_provider.dart';
import 'package:neo_bank/di/usecase/country/country_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';

import '../../feature/account_registration/add_email/add_email_model.dart';
import '../../feature/account_registration/add_email_otp/email_otp_model.dart';
import '../../feature/register/failure_scenarios/failure_scenarios_page_view_model.dart';
import '../../feature/register/manage_idwise_status/manage_idwise_status_model.dart';
import '../usecase/account/account_usecase_provider.dart';

///account registration view model provider
final accountRegistrationViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountRegistrationPageViewModel>(
  (ref) => AccountRegistrationPageViewModel(),
);

final addNumberViewModelProvider = ChangeNotifierProvider.autoDispose<AddNumberViewModel>(
  (ref) => AddNumberViewModel(
      ref.read(registerNumberUseCaseProvider),
      ref.read(checkUserNameMobileUseCaseProvider),
      ref.read(getAllowedCodeCountriesListUseCaseProvider),
      ref.read(sendMobileOTPUsecaseProvider)),
);

final addEmailViewModelProvider = ChangeNotifierProvider.autoDispose<AddEmailViewModel>(
  (ref) => AddEmailViewModel(ref.read(checkUserNameUseCaseProvider), ref.read(createPasswordUseCaseProvider)),
);

///[ValidateOtpViewModel] provider
final validateOtpViewModelProvider = ChangeNotifierProvider.autoDispose<ValidateOtpViewModel>(
  (ref) => ValidateOtpViewModel(
    ref.read(verifyOtpUseCaseProvider),
    ref.read(getTokenUseCaseProvider),
    ref.read(sendMobileOTPUsecaseProvider),
    ref.read(onboardingVerifyMobileOtpUsecase),
    ref.read(registerProspectUseCaseProvider),
  ),
);

///[ValidateOtpViewModel] provider
final emailOtpViewModelProvider = ChangeNotifierProvider.autoDispose<EmailOtpViewModel>(
  (ref) =>
      EmailOtpViewModel(ref.read(verifyEmailOtpUseCaseProvider), ref.read(resendEmailOTPUseCaseProvider)),
);

final manageIDWiseStatusViewModel = ChangeNotifierProvider.autoDispose<ManageIDWiseStatusViewModel>((ref) =>
    ManageIDWiseStatusViewModel(ref.read(processJourneyViaMobileUseCaseProvider),
        ref.read(checkJourneyStatusUseCaseProvider), ref.read(currentUserUseCaseProvider)));

final onboardingErrorScenariosPageViewModel =
    ChangeNotifierProvider.autoDispose<OnboardingFailureScenariosPageViewModel>(
  (ref) => OnboardingFailureScenariosPageViewModel(ref.read(logoutUseCaseProvider)),
);
