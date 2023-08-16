import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account_registration/account_regisration_usecase_provider.dart';
import 'package:neo_bank/di/usecase/country/country_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/account_registration/countryselection/country_selection_model.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';

import '../../feature/account_registration/add_email/add_email_model.dart';
import '../../feature/account_registration/add_email_otp/email_otp_model.dart';
import '../../feature/account_registration/failure_scenarios/failure_scenarios_page.dart';
import '../../feature/account_registration/failure_scenarios/failure_scenarios_page_view_model.dart';
import '../../feature/account_registration/manage_idwise_status/manage_idwise_status_model.dart';
import '../usecase/account/account_usecase_provider.dart';

///account registration view model provider
final accountRegistrationViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountRegistrationPageViewModel>(
  (ref) => AccountRegistrationPageViewModel(),
);

final countrySelectionViewModelProvider = ChangeNotifierProvider.autoDispose<CountrySelectionViewModel>(
  (ref) => CountrySelectionViewModel(
    ref.read(fetchCountriesUseCaseProvider),
  ),
);

final addNumberViewModelProvider = ChangeNotifierProvider.autoDispose<AddNumberViewModel>(
  (ref) => AddNumberViewModel(
      ref.read(registerNumberUseCaseProvider),
      ref.read(fetchCountryByCodeUseCaseProvider),
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
      ref.read(changeMyNumberUseCaseProvider),
      ref.read(sendMobileOTPUsecaseProvider),
      ref.read(onboardingVerifyMobileOtpUsecase)),
);

///[ValidateOtpViewModel] provider
final emailOtpViewModelProvider = ChangeNotifierProvider.autoDispose<EmailOtpViewModel>(
  (ref) =>
      EmailOtpViewModel(ref.read(verifyEmailOtpUseCaseProvider), ref.read(resendEmailOTPUseCaseProvider)),
);

///[CreatePasswordViewModel] provider
final createPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreatePasswordViewModel>((ref) => CreatePasswordViewModel(
          ref.read(createPasswordUseCaseProvider),
          ref.read(registerProspectUseCaseProvider),
        ));

final manageIDWiseStatusViewModel =
    ChangeNotifierProvider.autoDispose<ManageIDWiseStatusViewModel>((ref) => ManageIDWiseStatusViewModel());

final onboardingErrorScenariosPageViewModel = ChangeNotifierProvider.autoDispose
    .family<OnboardingFailureScenariosPageViewModel, OnboardingFailureScenarioArgument>(
  (ref, arg) => OnboardingFailureScenariosPageViewModel(argument: arg),
);
