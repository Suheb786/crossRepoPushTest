import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_model.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_model.dart';

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

///step three page view model provider
final registerStepThreeViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepThreeViewModel>(
  (ref) => RegisterStepThreeViewModel(),
);

///employment Status page view model provider
final employmentStatusPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<EmploymentStatusPageViewModel>(
  (ref) => EmploymentStatusPageViewModel(),
);
