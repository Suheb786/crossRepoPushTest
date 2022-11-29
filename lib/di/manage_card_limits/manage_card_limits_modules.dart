import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page_view_model.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_Debit_cards_page_view_model.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_debit_card_limits_page.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget_model.dart';

final manageCardLimitsViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ManageDebitCardLimitsPageViewModel, ManageCardLimitsArguments>((ref, args) =>
        ManageDebitCardLimitsPageViewModel(args, ref.read(debitCardLimitsUpdateUseCaseProvider),
            ref.read(creditCardLimitsUpdateUseCaseProvider), ref.read(debitCardLimitUseCaseProvider)));

///atm withdrawal
final atmWithdrawalViewModelProvider = ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///merchant payment
final merchantPaymentViewModelProvider = ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///online purchase
final onlinePurchaseViewModelProvider = ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///contactless payment
final contactLessPaymentViewModelProvider = ChangeNotifierProvider.autoDispose<ManageLimitsWidgetViewModel>(
  (ref) => ManageLimitsWidgetViewModel(),
);

///credit card limits view model
final manageCreditCardLimitsViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ManageCreditCardLimitsPageViewModel, ManageCreditCardLimitsArguments>((ref, args) =>
        ManageCreditCardLimitsPageViewModel(args, ref.read(getCreditCardLimitUseCaseProvider),
            ref.read(creditCardLimitsUpdateUseCaseProvider)));
