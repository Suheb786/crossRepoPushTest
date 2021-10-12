import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_model.dart';
import 'package:neo_bank/feature/register/stepone/createPassword/create_password_model.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_model.dart';
import 'package:neo_bank/feature/register/steptwo/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/feature/register/steptwo/enter_address/enter_address_model.dart';
import 'package:neo_bank/feature/register/steptwo/id_verification_info/id_verification_info_model.dart';

final registerViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterViewModel>(
  (ref) => RegisterViewModel(),
);

final registerStepOneViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepOneViewModel>(
  (ref) => RegisterStepOneViewModel(),
);

final countrySelectionViewModelProvider =
    ChangeNotifierProvider.autoDispose<CountrySelectionViewModel>(
  (ref) => CountrySelectionViewModel(
    ref.read(fetchCountriesUseCaseProvider),
  ),
);

final addNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNumberViewModel>(
  (ref) => AddNumberViewModel(ref.read(registerNumberUseCaseProvider)),
);

///[ValidateOtpViewModel] provider
final validateOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<ValidateOtpViewModel>(
  (ref) => ValidateOtpViewModel(ref.read(verifyOtpUseCaseProvider)),
);

///[CreatePasswordViewModel] provider
final createPasswordViewModelProvider = ChangeNotifierProvider.autoDispose<CreatePasswordViewModel>(
    (ref) => CreatePasswordViewModel(ref.read(createPasswordUseCaseProvider))
);

///[IdVerificationInfoViewModel] provider
final idVerificationInfoViewModelProvider = ChangeNotifierProvider.autoDispose<IdVerificationInfoViewModel>(
        (ref) => IdVerificationInfoViewModel(ref.read(idVerificationInfoUseCaseProvider))
);

///[ConfirmDetailViewModel] provider
final confirmDetailViewModelProvider = ChangeNotifierProvider.autoDispose<ConfirmDetailViewModel>(
        (ref) => ConfirmDetailViewModel(ref.read(confirmDetailUseCaseProvider))
);

///[EnterAddressViewModel] provider
final enterAddressViewModelProvider = ChangeNotifierProvider.autoDispose<EnterAddressViewModel>(
        (ref) => EnterAddressViewModel(ref.read(enterAddressUseCaseProvider))
);