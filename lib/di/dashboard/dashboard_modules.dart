import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/di/usecase/dashboard/dashboard_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/home/home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/placeholder/placeholder_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/download_transaction_dialog/download_transaction_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';

final dashboardViewModelProvider =
    ChangeNotifierProvider.autoDispose<DashboardPageViewModel>(
  (ref) => DashboardPageViewModel(
      ref.read(logoutUseCaseProvider),
      ref.read(checkBioMetricSupportUseCaseProvider),
      ref.read(authenticateBioMetricUseCaseProvider),
      ref.read(generateKeyPairUseCaseProvider),
      ref.read(enableBiometricUseCaseProvider)),
);

final biometricLoginViewModelProvider =
    ChangeNotifierProvider.autoDispose<BiometricLoginDialogViewModel>(
  (ref) =>
      BiometricLoginDialogViewModel(ref.read(enableFingerPrintUseCaseProvider)),
);

final getCreditCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<GetCreditCardViewModel>(
  (ref) => GetCreditCardViewModel(ref.read(getCardUseCaseProvider)),
);

final placeholderViewModelProvider =
    ChangeNotifierProvider.autoDispose<PlaceholderViewModel>(
  (ref) => PlaceholderViewModel(ref.read(placeholderUseCaseProvider)),
);

final appHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<AppHomeViewModel>(
  (ref) => AppHomeViewModel(ref.read(getDashboardDataUseCaseProvider)),
);

final filterTransactionDialogViewModelProvier =
    ChangeNotifierProvider.autoDispose<FilterTransactionDialogViewModel>(
        (ref) => FilterTransactionDialogViewModel());

final myAccountViewModelProvider =
    ChangeNotifierProvider.autoDispose<MyAccountViewModel>(
  (ref) => MyAccountViewModel(ref.read(myAccountUseCaseProvider)),
);

final myDebitCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<MyDebitCardViewModel>(
  (ref) => MyDebitCardViewModel(ref.read(myDebitCardUseCaseProvider)),
);

final cardDeliveredViewModelProvider =
    ChangeNotifierProvider.autoDispose<DebitCardDeliveredViewModel>(
  (ref) => DebitCardDeliveredViewModel(ref.read(cardDeliveredUseCaseProvider)),
);

final debitCardVerificationSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<DebitCardVerificationSuccessViewModel>(
  (ref) => DebitCardVerificationSuccessViewModel(
      ref.read(debitCardVerificationSuccessUseCaseProvider)),
);

final cardTransactionViewModelProvider =
    ChangeNotifierProvider.autoDispose<CardTransactionViewModel>(
  (ref) => CardTransactionViewModel(ref.read(cardTransactionUseCaseProvider)),
);

final creditCardDeliveredViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditCardDeliveredViewModel>(
  (ref) => CreditCardDeliveredViewModel(
      ref.read(creditCardDeliveredUseCaseProvider)),
);

final creditCardVerificationSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditCardVerificationSuccessViewModel>(
  (ref) => CreditCardVerificationSuccessViewModel(
      ref.read(creditCardVerificationSuccessUseCaseProvider)),
);

final accountTransactionViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountTransactionViewModel>(
  (ref) => AccountTransactionViewModel(
      ref.read(accountTransactionUseCaseProvider),
      ref.read(debitCardTransactionUseCaseProvider)),
);

final homeViewModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(),
);

final debitCardTimeLineViewModelProvider =
    ChangeNotifierProvider.autoDispose<DebitCardTimeLineViewModel>(
  (ref) =>
      DebitCardTimeLineViewModel(ref.read(debitCardTimeLineUseCaseProvider)),
);

///add money option selector view model
final addMoneyOptionSelectorViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddMoneyOptionSelectorViewModel>(
  (ref) => AddMoneyOptionSelectorViewModel(),
);

///locate pin page view model
final locatePinViewModelProvider =
    ChangeNotifierProvider.autoDispose<LocateATMPageViewModel>(
  (ref) => LocateATMPageViewModel(ref.read(getAtmUseCaseProvider)),
);

///settings dialog view model
final settingsDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<SettingsDialogViewModel>(
  (ref) => SettingsDialogViewModel(),
);

final downloadTransactionDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<DownloadTransactionDialogViewModel>(
        (ref) => DownloadTransactionDialogViewModel());

final downloadTransactionViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<DownloadTransactionViewModel, List<String>>(
  (
    ref,
    args,
  ) =>
      DownloadTransactionViewModel(
          ref.read(downloadCardTransactionUseCaseProvider), args),
);