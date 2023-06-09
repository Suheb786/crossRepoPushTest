import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account/account_usecase_provider.dart';
import 'package:neo_bank/di/usecase/account_setting/account_setting_usecase_provider.dart';
import 'package:neo_bank/di/usecase/country/country_usecase_provider.dart';
import 'package:neo_bank/di/usecase/help_center/help_center_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/add_new_email/add_new_email_address_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/change_email_address_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/enter_code_for_change_email_address/enter_code_for_change_email_address_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/add_new_mobile_number/add_new_mobile_number_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/change_mobile_number_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/enter_code_for_change_mobile_number/enter_code_for_change_mobile_number_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_password/change_password_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_password/enter_new_password/enter_new_password_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/my_documents/my_documents_page_view_model.dart';

///account setting view model provider
final accountSettingViewModelProvider = ChangeNotifierProvider.autoDispose<AccountSettingPageViewModel>(
  (ref) => AccountSettingPageViewModel(
      ref.read(uploadDocumentUseCaseProvider),
      ref.read(checkBioMetricSupportUseCaseProvider),
      ref.read(authenticateBioMetricUseCaseProvider),
      ref.read(getProfileInfoUseCaseProvider),
      ref.read(generateKeyPairUseCaseProvider),
      ref.read(enableBiometricUseCaseProvider),
      ref.read(uploadProfileImageUseCaseProvider),
      ref.read(disableFingerPrintUseCaseProvider),
      ref.read(deleteProfileImageUseCaseProvider)),
);

///change email address view model provider
final changeEmailAddressViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeEmailAddressPageViewModel>(
  (ref) => ChangeEmailAddressPageViewModel(),
);

///add new email address view model provider
final addNewEmailAddressViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNewEmailAddressPageViewModel>(
  (ref) => AddNewEmailAddressPageViewModel(ref.read(addNewEmailAddressUseCaseProvider)),
);

///enter otp view model provider
final enterOtpForNewEmailAddressViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterCodeForChangeEmailAddressPageViewModel>(
  (ref) => EnterCodeForChangeEmailAddressPageViewModel(
    ref.read(validateOtpNewEmailAddressUseCaseProvider),
    ref.read(addNewEmailAddressUseCaseProvider),
  ),
);

///change mobile number view model provider
final changeMobileNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeMobileNumberPageViewModel>(
  (ref) => ChangeMobileNumberPageViewModel(),
);

///add new number view model provider
final addNewMobileNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNewMobileNumberPageViewModel>(
  (ref) => AddNewMobileNumberPageViewModel(
      ref.read(addNewNumberUseCaseProvider), ref.read(getAllowedCodeCountriesListUseCaseProvider)),
);

///enter otp for mobile no change view model provider
final enterOtpForNewMobileNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterCodeForChangeMobileNumberPageViewModel>(
        (ref) => EnterCodeForChangeMobileNumberPageViewModel(
              ref.read(validateOtpNewMobileNumberUseCaseProvider),
              ref.read(addNewNumberUseCaseProvider),
            ));

///change password view model provider
final changePasswordViewModelProvider = ChangeNotifierProvider.autoDispose<ChangePasswordPageViewModel>(
  (ref) => ChangePasswordPageViewModel(),
);

///enter new password view model provider
final enterNewPasswordViewModelProvider = ChangeNotifierProvider.autoDispose<EnterNewPasswordPageViewModel>(
  (ref) => EnterNewPasswordPageViewModel(ref.read(enterNewPasswordUseCaseProvider)),
);

///my documents page
final myDocumentsPageViewModelProvider = ChangeNotifierProvider.autoDispose<MyDocumentsPageViewModel>(
  (ref) => MyDocumentsPageViewModel(
      ref.read(myDocumentUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider),
      ref.read(checkOtherNationalityStatusUseCaseProvider),
      ref.read(fileUploadUseCaseProvider),
      ref.read(getCustomerDocIdUseCaseProvider),
      ref.read(getCustomerDocUseCaseProvider)),
);

///base card view model provider
final baseCardViewModelProvider = ChangeNotifierProvider.autoDispose<BaseCardPageViewModel>(
  (ref) => BaseCardPageViewModel(),
);
