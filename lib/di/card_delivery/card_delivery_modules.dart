import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/confirm_pin/confirm_pin_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/create_pin/create_pin_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view_model.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/enter_new_pin_for_card/enter_new_pin_for_card_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/otp_for_change_card_pin/otp_for_change_card_pin_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';

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

///manage card pin viewmodel provider
final manageCardPinViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ManageCardPinViewModel, ManageCardPinArguments>(
  (ref, args) => ManageCardPinViewModel(
      args,
      ref.read(unBlockDebitCardUseCaseProvider),
      ref.read(unBlockCreditCardUseCaseProvider)),
);

///Card pin unblock success view model provider
final cardPinUnblockSuccessViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<CardPinUnBlockSuccessPageViewModel, ManageCardPinArguments>(
  (ref, args) => CardPinUnBlockSuccessPageViewModel(args),
);

///change card pin view model provider
final changeCardPinViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeCardPinPageViewModel>(
  (ref) => ChangeCardPinPageViewModel(),
);

///change card pin view model provider
final otpForChangeCardPinViewModelProvider =
    ChangeNotifierProvider.autoDispose<OtpForChangeCardPinPageViewModel>(
  (ref) => OtpForChangeCardPinPageViewModel(
      ref.read(otpForChangeCardPinUseCaseProvider)),
);

///enter new card pin view model provider
final enterNewCardPinViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterNewPinForCardPageViewModel>(
  (ref) => EnterNewPinForCardPageViewModel(
      ref.read(enterNewPinForCardUseCaseProvider)),
);

///change card pin success view model provider
final changeCardPinSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeCardPinSuccessPageViewModel>(
  (ref) => ChangeCardPinSuccessPageViewModel(),
);
