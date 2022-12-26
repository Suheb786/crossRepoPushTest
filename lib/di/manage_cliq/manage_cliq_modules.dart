import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/country/country_usecase_provider.dart';
import 'package:neo_bank/di/usecase/manage_cliq_id/manage_cliq_id_usecase.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/click_id_type_selection/cliq_id_type_selection_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/create_cliq_id_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/enter_otp_for_cliq_id/enter_otp_for_cliq_id_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_cliq_id_mobile_no/edit_cliq_id_mobile_no_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_cliq_id_mobile_no/edit_cliq_id_mobile_no_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/otp_for_edit_alias_and_mobile_no/otp_for_edit_alias_mobile_no_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/otp_for_edit_alias_and_mobile_no/otp_for_edit_alias_mobile_no_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/add_new_mobile_cliq/add_new_mobile_no_cliq_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/edit_mobile_no_cliq_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/enter_otp_for_mobile_number_cliq/enter_otp_for_mobile_no_cliq_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/link_account/link_account_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_information_dialog/cliq_information_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/link_account_dialog/link_account_dialog_view_model.dart';

final cliqIdListViewModelProvider = ChangeNotifierProvider.autoDispose<CliqIdListPageViewModel>(
  (ref) => CliqIdListPageViewModel(
      ref.read(getAliasUseCaseProvider),
      ref.read(deleteCliqIdUseCaseProvider),
      ref.read(unLinkAccountFromCliqUseCaseProvider),
      ref.read(confirmChangeDefaultAccountUseCaseProvider),
      ref.read(suspendCliqIdUseCaseProvider),
      ref.read(reActivateCliqIdUseCaseProvider),
      ref.read(addLinkAccountUseCaseProvider)),
);

///create cliq id
final createCliqIdViewModelProvider = ChangeNotifierProvider.autoDispose<CreateCliqIdPageViewModel>(
  (ref) => CreateCliqIdPageViewModel(),
);

final cliqIdTypeSelectionViewModelProvider =
    ChangeNotifierProvider.autoDispose<CliqIdTypeSelectionPageViewModel>(
  (ref) => CliqIdTypeSelectionPageViewModel(ref.read(cliqIdTypSelectioneUseCaseProvider)),
);

///link bank account to cliq id view model
final linkBankAccountCliqIdViewModelProvider =
    ChangeNotifierProvider.autoDispose<LinkBankAccountCliqIdPageViewModel>(
          (ref) =>
          LinkBankAccountCliqIdPageViewModel(ref.read(linkBankAccountCliqIdValidationUseCaseProvider),
              ref.read(createCliqIdOtpUseCaseProvider), ref.read(getAccountByCustomerID)),
    );

///enter otp for cliq id view model
final enterOtpFortCliqIdViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpForCliqIdPageViewModel>(
  (ref) => EnterOtpForCliqIdPageViewModel(ref.read(enterOtpForCliqIdUseCaseProvider),
      ref.read(confirmCreateCliqIdUseCaseProvider), ref.read(createCliqIdOtpUseCaseProvider)),
);

final otpForEditAliasAndMobileNoPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<OtpForEditAliasAndMobileNoPageViewModel, OtpForEditAliasAndMobileNoPageArguments>(
  (ref, args) => OtpForEditAliasAndMobileNoPageViewModel(ref.read(enterOtpForCliqIdUseCaseProvider),
      ref.read(editCliqIdUseCaseProvider), args, ref.read(editCliqOtpUseCaseProvider)),
);

///cliq id creation success view model
final cliqIdCreationSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<CliqIdCreationSuccessPageViewModel>(
  (ref) => CliqIdCreationSuccessPageViewModel(),
);

///edit alias view model
final editAliasViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<EditAliasPageViewModel, EditAliasPageArguments>(
  (ref, args) => EditAliasPageViewModel(
      ref.read(editAliasValidationUseCaseProvider), ref.read(editCliqOtpUseCaseProvider), args),
);

final editCliqIDMobileNoPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<EditCliqIDMobileNoPageViewModel, EditCliqIDMobileNoPageArguments>(
  (ref, args) => EditCliqIDMobileNoPageViewModel(
      ref.read(editCliqMobileNoValidationUseCaseProvider), ref.read(editCliqOtpUseCaseProvider), args),
);

///edit mobile number cliq
final editMobileNoViewModelProvider = ChangeNotifierProvider.autoDispose<EditMobileNoCliqPageViewModel>(
  (ref) => EditMobileNoCliqPageViewModel(),
);

/// add new mobile no cliq
final addNewMobileNumberCliqViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNewMobileNumberCliqPageViewModel>(
  (ref) => AddNewMobileNumberCliqPageViewModel(
      ref.read(addNewMobileNumberCliqUseCaseProvider), ref.read(getAllowedCodeCountriesListUseCaseProvider)),
);

/// enter otp for mobile no cliq
final enterOtpForMobileNoCliqViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpForMobileNumberCliqPageViewModel>(
  (ref) => EnterOtpForMobileNumberCliqPageViewModel(
    ref.read(enterOtpForMobileNumberCliqUseCaseProvider),
  ),
);

final linkAccountDialogViewModelProvider = ChangeNotifierProvider.autoDispose<LinkAccountDialogViewModel>(
  (ref) => LinkAccountDialogViewModel(),
);

final cliqInformationDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CliqInformationDialogViewModel>(
  (ref) => CliqInformationDialogViewModel(),
);

final linkAccountPageViewModelProvider = ChangeNotifierProvider.autoDispose<LinkAccountPageViewModel>(
  (ref) => LinkAccountPageViewModel(ref.read(linkBankAccountCliqIdValidationUseCaseProvider)),
);
