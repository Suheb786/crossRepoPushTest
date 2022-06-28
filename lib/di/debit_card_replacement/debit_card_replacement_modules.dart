import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/di/usecase/debit_card_replacement/debit_card_replacement_usecase_provider.dart';
import 'package:neo_bank/feature/debit_card_replacement/confirm_pin/confirm_replacement_pin_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/create_pin/create_replacement_pin_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/visa_card/replacement_visa_card_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/confirm_pin/supp_confirm_pin_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/create_pin/supp_create_pin_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/supplementary_debit_card_pin_set_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/visa_card/supp_pin_set_visa_card_page_view_model.dart';

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
final cardReplacementSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<
        DebitCardReplacementSuccessPageViewModel,
        DebitCardReplacementSuccessPageArgs>(
  (ref, args) => DebitCardReplacementSuccessPageViewModel(args),
);

///supp debit card set pin view model provider
final suppDebitCardPinSetViewModelProvider = ChangeNotifierProvider.autoDispose<
    SupplementaryDebitCardPinSetPageViewModel>(
  (ref) => SupplementaryDebitCardPinSetPageViewModel(),
);

///supp pin set view model provider
final suppPinSetVisaCardModelProvider =
    ChangeNotifierProvider.autoDispose<SuppPinSetVisaCardPageViewModel>(
  (ref) => SuppPinSetVisaCardPageViewModel(),
);

///supp create pin  view model provider
final suppCreatePinModelProvider =
    ChangeNotifierProvider.autoDispose<SuppCreatePinPageViewModel>(
  (ref) => SuppCreatePinPageViewModel(ref.read(createPinUseCaseProvider)),
);

///supp confirm pin  view model provider
final suppConfirmPinModelProvider =
    ChangeNotifierProvider.autoDispose<SuppConfirmPinPageViewModel>(
  (ref) => SuppConfirmPinPageViewModel(
      ref.read(confirmReplacementPinUseCaseProvider)),
);
