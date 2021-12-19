import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/confirm_pin/confirm_pin_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/create_pin/create_pin_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view_model.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page_view_model.dart';

///card delivery view model provider
final cardDeliveryViewModelProvider =
ChangeNotifierProvider.autoDispose<CardDeliveryPageViewModel>(
      (ref) => CardDeliveryPageViewModel(),
);

///create pin view model provider
final createPinViewModelProvider =
ChangeNotifierProvider.autoDispose<CreatePinPageViewModel>(
      (ref) => CreatePinPageViewModel(ref.read(createPinUseCaseProvider)),
);

///confirm pin view model provider
final confirmPinViewModelProvider =
ChangeNotifierProvider.autoDispose<ConfirmPinPageViewModel>(
      (ref) => ConfirmPinPageViewModel(ref.read(confirmPinUseCaseProvider)),
);

///visa card view model provider
final visaCardViewModelProvider =
ChangeNotifierProvider.autoDispose<VisaCardPageViewModel>(
      (ref) => VisaCardPageViewModel(ref.read(cardIssuanceCaseProvider)),
);

///card ready success view model provider
final cardReadySuccessViewModelProvider =
ChangeNotifierProvider.autoDispose<CardReadySuccessPageViewModel>(
      (ref) => CardReadySuccessPageViewModel(),
);
