import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/di/usecase/debit_card_replacement/debit_card_replacement_usecase_provider.dart';
import 'package:neo_bank/feature/debit_card_replacement/confirm_pin/confirm_replacement_pin_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/create_pin/create_replacement_pin_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/visa_card/replacement_visa_card_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view_model.dart';

///debit card replacement view model provider
final debitCardReplacementViewModelProvider =
    ChangeNotifierProvider.autoDispose<DebitCardReplacementPageViewModel>(
  (ref) => DebitCardReplacementPageViewModel(),
);

///replacement visa card view model provider
final replacementVisaCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<ReplacementVisaCardPageViewModel>(
  (ref) => ReplacementVisaCardPageViewModel(ref.read(cardIssuanceCaseProvider)),
);

///create replacement pin view model provider
final createReplacementPinViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreateReplacementPinPageViewModel>(
  (ref) =>
      CreateReplacementPinPageViewModel(ref.read(createPinUseCaseProvider)),
);

///confirm replacement pin view model provider
final confirmReplacementPinViewModelProvider =
    ChangeNotifierProvider.autoDispose<ConfirmReplacementPinPageViewModel>(
  (ref) => ConfirmReplacementPinPageViewModel(
      ref.read(confirmReplacementPinUseCaseProvider)),
);

///card replacement success view model provider
final cardReplacementSuccessViewModelProvider = ChangeNotifierProvider
    .autoDispose<DebitCardReplacementSuccessPageViewModel>(
  (ref) => DebitCardReplacementSuccessPageViewModel(),
);
