import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account_registration/account_regisration_usecase_provider.dart';
import 'package:neo_bank/di/usecase/country/country_usecase_provider.dart';
import 'package:neo_bank/di/usecase/dc_change_linked_mobile_number/dc_change_linked_mobile_number_usecase_provider.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_view_model.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_view_model.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_new_mobile_number/dc_enter_new_mobile_number_page_view_model.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_otp/dc_enter_otp_view_model.dart';

final dcChangeLinkedMobileNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcChangeLinkedMobileNumberViewModel>(
  (ref) => DcChangeLinkedMobileNumberViewModel(),
);

final dcEnterNewMobileNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcEnterNewMobileNumberPageViewModel>(
  (ref) => DcEnterNewMobileNumberPageViewModel(
      ref.read(fetchCountryByCodeUseCaseProvider),
      ref.read(getAllowedCodeCountriesListUseCaseProvider),
      ref.read(dcEnterNewMobileNumberUseCaseProvider)),
);

final dcEnterOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcEnterOtpViewModel>(
  (ref) => DcEnterOtpViewModel(ref.read(dcEnterOtpUseCaseProvider)),
);

final dcChangeMobileNumberSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcChangeMobileNumberSuccessViewModel>(
  (ref) => DcChangeMobileNumberSuccessViewModel(),
);
