import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/apple_pay/apple_pay_usecase_provider.dart';
import 'package:neo_bank/feature/apple_pay/apple_pay_success/apple_pay_success_and_error_page.dart';
import 'package:neo_bank/feature/apple_pay/apple_pay_success/apple_pay_success_and_error_page_view_model.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_view_model.dart';

///selected card for apple pay vm provider
final selectedCardForApplePayPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<SelectedCardForApplePayPageViewModel, SelectedCardsForApplePayPageArguments>(
  (ref, args) => SelectedCardForApplePayPageViewModel(args, ref.read(getAntelopCardListUseCaseProvider)),
);

///apple Pay Success Page vm provider
final applePaySuccessAndErrorPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ApplePaySuccessAndErrorPageViewModel, ApplePaySuccessAndErrorPageArguments>(
  (ref, args) => ApplePaySuccessAndErrorPageViewModel(args),
);
