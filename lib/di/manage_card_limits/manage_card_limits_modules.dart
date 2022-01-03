import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/debit_card_settings/debit_card_settings_usecase_provider.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_Debit_cards_page_view_model.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget_model.dart';

final manageCardLimitsViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageDebitCardLimitsPageViewModel>(
  (ref) => ManageDebitCardLimitsPageViewModel(
      ref.read(manageDebitCardLimitsUseCaseProvider)),
);

///atm withdrawal
final atmWithdrawalViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///merchant payment
final merchantPaymentViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///online purchase
final onlinePurchaseViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///contactless payment
final contactLessPaymentViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);
