import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account_registration/account_regisration_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/account_registration/countryselection/country_selection_model.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';

///account registration view model provider
final accountRegistrationViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountRegistrationPageViewModel>(
  (ref) => AccountRegistrationPageViewModel(),
);

final countrySelectionViewModelProvider =
    ChangeNotifierProvider.autoDispose<CountrySelectionViewModel>(
  (ref) => CountrySelectionViewModel(
    ref.read(fetchCountriesUseCaseProvider),
  ),
);

final addNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNumberViewModel>(
  (ref) => AddNumberViewModel(
      ref.read(registerNumberUseCaseProvider),
      ref.read(fetchCountryByCodeUseCaseProvider),
      ref.read(checkUserNameUseCaseProvider),
      ref.read(checkUserNameMobileUseCaseProvider)),
);

///[ValidateOtpViewModel] provider
final validateOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<ValidateOtpViewModel>(
  (ref) => ValidateOtpViewModel(ref.read(verifyOtpUseCaseProvider)),
);

///[CreatePasswordViewModel] provider
final createPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreatePasswordViewModel>((ref) =>
        CreatePasswordViewModel(ref.read(createPasswordUseCaseProvider)));
