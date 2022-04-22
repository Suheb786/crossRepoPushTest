import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/country/country_usecase_provider.dart';
import 'package:neo_bank/di/usecase/manage_cliq_id/manage_cliq_id_usecase.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/click_id_type_selection/cliq_id_type_selection_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/create_cliq_id_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/enter_otp_for_cliq_id/enter_otp_for_cliq_id_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/add_new_mobile_cliq/add_new_mobile_no_cliq_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/edit_mobile_no_cliq_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/enter_otp_for_mobile_number_cliq/enter_otp_for_mobile_no_cliq_page_view_model.dart';

final cliqIdListViewModelProvider =
    ChangeNotifierProvider.autoDispose<CliqIdListPageViewModel>(
  (ref) => CliqIdListPageViewModel(),
);

///create cliq id
final createCliqIdViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreateCliqIdPageViewModel>(
  (ref) => CreateCliqIdPageViewModel(),
);

final CliqIdTypeSelectionViewModelProvider =
    ChangeNotifierProvider.autoDispose<CliqIdTypeSelectionPageViewModel>(
  (ref) => CliqIdTypeSelectionPageViewModel(
      ref.read(cliqIdTypSelectioneUseCaseProvider)),
);

///link bank account to cliq id view model
final linkBankAccountCliqIdViewModelProvider =
    ChangeNotifierProvider.autoDispose<LinkBankAccountCliqIdPageViewModel>(
  (ref) => LinkBankAccountCliqIdPageViewModel(),
);

///enter otp for cliq id view model
final enterOtpFortCliqIdViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpForCliqIdPageViewModel>(
  (ref) => EnterOtpForCliqIdPageViewModel(
      ref.read(enterOtpForCliqIdUseCaseProvider)),
);

///cliq id creation success view model
final cliqIdCreationSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<CliqIdCreationSuccessPageViewModel>(
  (ref) => CliqIdCreationSuccessPageViewModel(),
);

///edit alias view model
final editAliasViewModelProvider =
    ChangeNotifierProvider.autoDispose<EditAliasPageViewModel>(
  (ref) => EditAliasPageViewModel(),
);

///edit mobile number cliq
final editMobileNoViewModelProvider =
    ChangeNotifierProvider.autoDispose<EditMobileNoCliqPageViewModel>(
  (ref) => EditMobileNoCliqPageViewModel(),
);

/// add new mobile no cliq
final addNewMobileNumberCliqViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNewMobileNumberCliqPageViewModel>(
  (ref) => AddNewMobileNumberCliqPageViewModel(
      ref.read(addNewMobileNumberCliqUseCaseProvider),
      ref.read(getAllowedCodeCountriesListUseCaseProvider)),
);

/// enter otp for mobile no cliq
final enterOtpForMobileNoCliqViewModelProvider = ChangeNotifierProvider
    .autoDispose<EnterOtpForMobileNumberCliqPageViewModel>(
  (ref) => EnterOtpForMobileNumberCliqPageViewModel(
    ref.read(enterOtpForMobileNumberCliqUseCaseProvider),
  ),
);
