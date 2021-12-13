import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account_setting/account_setting_usecase_provider.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/add_new_email/add_new_email_address_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/change_email_address_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/enter_code_for_change_email_address/enter_code_for_change_email_address_page_view_model.dart';

///account setting view model provider
final accountSettingViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountSettingPageViewModel>(
  (ref) => AccountSettingPageViewModel(),
);

///change email address view model provider
final changeEmailAddressViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeEmailAddressPageViewModel>(
  (ref) => ChangeEmailAddressPageViewModel(),
);

///add new email address view model provider
final addNewEmailAddressViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNewEmailAddressPageViewModel>(
  (ref) => AddNewEmailAddressPageViewModel(
      ref.read(addNewEmailAddressUseCaseProvider)),
);

///enter otp view model provider
final enterOtpForNewEmailAddressViewModelProvider = ChangeNotifierProvider
    .autoDispose<EnterCodeForChangeEmailAddressPageViewModel>(
  (ref) => EnterCodeForChangeEmailAddressPageViewModel(
      ref.read(validateOtpNewEmailAddressUseCaseProvider)),
);
