import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/blink_credit_card/blink_credit_card_usecase_provider.dart';
import 'package:neo_bank/feature/blink_credit_card/blink_credit_card_view_model.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_view_model.dart';

final blinkCreditCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<BlinkCreditCardViewModel>(
  (ref) => BlinkCreditCardViewModel(ref.read(blinkCreditCardUseCaseProvider)),
);

final creditCardApplicationFailureViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditCardApplicationFailureViewModel>(
  (ref) => CreditCardApplicationFailureViewModel(
      ref.read(creditCardApplicationFailureUseCaseProvider)),
);
