import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account_setting/account_setting_usecase_provider.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/di/usecase/dashboard/dashboard_usecase_provider.dart';
import 'package:neo_bank/di/usecase/dc_change_linked_mobile_number/dc_change_linked_mobile_number_usecase_provider.dart';
import 'package:neo_bank/di/usecase/debit_card_settings/debit_card_settings_usecase_provider.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/change_country_restriction/change_country_restriction_page_view_model.dart';
import 'package:neo_bank/feature/change_credit_limit/change_credit_limit_page_view_model.dart';
import 'package:neo_bank/feature/covert_purchase_to_installements/covert_purchase_to_installments_page_view_model.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/home/home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/placeholder/placeholder_view_model.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_payment_account/change_card_payment_account_page_view_model.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page_view_model.dart';
import 'package:neo_bank/feature/manage_credit_settlement/manage_credit_settlement_page_view_model.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page_view_model.dart';
import 'package:neo_bank/feature/renew_credit_card/renew_credit_card_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/download_transaction_dialog/download_transaction_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';

final dashboardViewModelProvider = ChangeNotifierProvider.autoDispose<DashboardPageViewModel>(
  (ref) => DashboardPageViewModel(
      ref.read(logoutUseCaseProvider),
      ref.read(checkBioMetricSupportUseCaseProvider),
      ref.read(authenticateBioMetricUseCaseProvider),
      ref.read(generateKeyPairUseCaseProvider),
      ref.read(enableBiometricUseCaseProvider)),
);

final biometricLoginViewModelProvider = ChangeNotifierProvider.autoDispose<BiometricLoginDialogViewModel>(
  (ref) => BiometricLoginDialogViewModel(ref.read(enableFingerPrintUseCaseProvider)),
);

final getCreditCardViewModelProvider = ChangeNotifierProvider.autoDispose<GetCreditCardViewModel>(
  (ref) => GetCreditCardViewModel(ref.read(getCardUseCaseProvider)),
);

final placeholderViewModelProvider = ChangeNotifierProvider.autoDispose<PlaceholderViewModel>(
  (ref) => PlaceholderViewModel(ref.read(placeholderUseCaseProvider)),
);

final appHomeViewModelProvider = ChangeNotifierProvider.autoDispose<AppHomeViewModel>(
  (ref) => AppHomeViewModel(
      ref.read(getDashboardDataUseCaseProvider),
      ref.read(getPlaceHolderUseCaseProvider),
      ref.read(initDynamicLinkUseCaseProvider),
      ref.read(currentUserUseCaseProvider),
      ref.read(saveDataUserUseCaseProvider)),
);

final filterTransactionDialogViewModelProvier =
    ChangeNotifierProvider.autoDispose<FilterTransactionDialogViewModel>(
        (ref) => FilterTransactionDialogViewModel());

final myAccountViewModelProvider = ChangeNotifierProvider.autoDispose<MyAccountViewModel>(
  (ref) => MyAccountViewModel(ref.read(myAccountUseCaseProvider)),
);

final myDebitCardViewModelProvider = ChangeNotifierProvider.autoDispose<MyDebitCardViewModel>(
  (ref) => MyDebitCardViewModel(ref.read(myDebitCardUseCaseProvider)),
);

final cardDeliveredViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<DebitCardDeliveredViewModel, TimeLineListArguments>(
  (ref, args) => DebitCardDeliveredViewModel(ref.read(debitCardConfirmDeliveryCaseProvider), args),
);

final debitCardVerificationSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<DebitCardVerificationSuccessViewModel>(
  (ref) => DebitCardVerificationSuccessViewModel(ref.read(debitCardVerificationSuccessUseCaseProvider)),
);

final cardTransactionViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<CardTransactionViewModel, GetCreditCardTransactionArguments>(
  (ref, args) => CardTransactionViewModel(
      ref.read(creditCardTransactionUseCaseProvider), ref.read(getCreditYearsUseCaseProvider), args),
);

final creditCardDeliveredViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<CreditCardDeliveredViewModel, TimeLineListArguments>(
  (ref, args) => CreditCardDeliveredViewModel(ref.read(confirmCreditCardDeliveryUseCaseProvider), args),
);

final creditCardVerificationSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditCardVerificationSuccessViewModel>(
  (ref) => CreditCardVerificationSuccessViewModel(ref.read(creditCardVerificationSuccessUseCaseProvider)),
);

final accountTransactionViewModelProvider = ChangeNotifierProvider.autoDispose<AccountTransactionViewModel>(
  (ref) => AccountTransactionViewModel(ref.read(accountTransactionUseCaseProvider),
      ref.read(debitCardTransactionUseCaseProvider), ref.read(getDebitYearsUseCaseProvider)),
);

final homeViewModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(),
);

final debitCardTimeLineViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<DebitCardTimeLineViewModel, TimeLinePageArguments>(
  (ref, args) => DebitCardTimeLineViewModel(ref.read(debitCardTimeLineUseCaseProvider), args),
);

///add money option selector view model
final addMoneyOptionSelectorViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddMoneyOptionSelectorViewModel>(
  (ref) => AddMoneyOptionSelectorViewModel(ref.read(getPlaceHolderUseCaseProvider)),
);

///locate pin page view model
final locatePinViewModelProvider = ChangeNotifierProvider.autoDispose<LocateATMPageViewModel>(
  (ref) => LocateATMPageViewModel(ref.read(getAtmUseCaseProvider)),
);

///settings dialog view model
final settingsDialogViewModelProvider = ChangeNotifierProvider.autoDispose<SettingsDialogViewModel>(
  (ref) => SettingsDialogViewModel(
    ref.read(logoutUseCaseProvider),
    ref.read(getProfileInfoUseCaseProvider),
  ),
);

final downloadTransactionDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<DownloadTransactionDialogViewModel>(
        (ref) => DownloadTransactionDialogViewModel());

final downloadTransactionViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<DownloadTransactionViewModel, DownloadStatementArguments>(
  (
    ref,
    args,
  ) =>
      DownloadTransactionViewModel(
    ref.read(downloadCardTransactionUseCaseProvider),
    ref.read(cardStatementUseCaseProvider),
    args,
  ),
);

/// DEBIT CArd Settings
final debitCardSettingsViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<DebitCardSettingsViewModel, DebitCardSettingsArguments>(
  (ref, args) => DebitCardSettingsViewModel(
      ref.read(freezeDebitCardUseCaseProvider),
      ref.read(unFreezeDebitCardUseCaseProvider),
      ref.read(cancelDebitCardUseCaseProvider),
      args,
      ref.read(removeOrReapplySuppDebitUseCaseProvider),
      ref.read(removeOrReapplySuppDebitWithResponseUseCaseProvider),
      ref.read(requestPhysicalDebitCardUseCaseProvider)),
);

/// Credit CArd Settings
final creditCardSettingsViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<CreditCardSettingsViewModel, CreditCardSettingsArguments>(
  (ref, args) => CreditCardSettingsViewModel(
      ref.read(freezeCreditCardUseCaseProvider),
      ref.read(unFreezeCreditCardUseCaseProvider),
      ref.read(cancelCreditCardUseCaseProvider),
      args,
      ref.read(getSupplementaryCreditCardApplicationUseCaseProvider),
      ref.read(reportLostStolenCCUseCaseProvider)),
);

/// check rescheduled video call
final checkRescheduledVideoCallViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<CheckScheduledVideoCallPageViewModel, CheckVideoCallScheduledArguments>(
  (ref, args) => CheckScheduledVideoCallPageViewModel(ref.read(logoutUseCaseProvider), args),
);

///change country restriction page view model
final changeCountryRestrictionPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeCountryRestrictionPageViewModel>(
  (ref) => ChangeCountryRestrictionPageViewModel(),
);

///manage credit settlement page view model
final manageCreditSettlementPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageCreditSettlementViewModel>(
  (ref) => ManageCreditSettlementViewModel(),
);

///change card payment page view model
final changeCardPaymentPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeCardPaymentAccountPageViewModel>(
  (ref) => ChangeCardPaymentAccountPageViewModel(),
);

///change card settlement percentage page view model
final changeCardSettlementPercentagePageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeCardSettlementPercentagePageViewModel>(
  (ref) => ChangeCardSettlementPercentagePageViewModel(ref.read(updateSettlementUseCaseProvider)),
);

///renew credit card page view model
final renewCreditCardPageViewModelProvider = ChangeNotifierProvider.autoDispose<RenewCreditCardPageViewModel>(
  (ref) => RenewCreditCardPageViewModel(),
);

///change credit limit page view model
final changeCreditLimitPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeCreditLimitPageViewModel>(
  (ref) => ChangeCreditLimitPageViewModel(),
);

///convert purchase to installments page view model
final convertPurchaseToInstallmentsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ConvertPurchaseToInstallmentsPageViewModel>(
  (ref) => ConvertPurchaseToInstallmentsPageViewModel(),
);
