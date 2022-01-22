import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/confirm_pin/confirm_pin_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/create_pin/create_pin_page_view_model.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view_model.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/enter_new_pin_for_card/enter_new_pin_for_card_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/otp_for_change_card_pin/otp_for_change_card_pin_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';
import 'package:neo_bank/feature/supplementary_card_in_review/supplementary_card_in_review_page.dart';
import 'package:neo_bank/feature/supplementary_card_in_review/supplementary_card_in_review_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card/personalize_credit_card/personalize_credit_card_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card/relationship_with_cardholder/relationship_with_cardholder_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card/supplementary_credit_card_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card_ready/supplementary_credit_card_ready_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card/personalize_debit_card/personalize_debit_card_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card/relationship_with_cardholder_debit/relationship_with_cardholder_debit_page_view_model.dart';
import 'package:neo_bank/feature/supplementary_debit_card/supplementary_debit_card_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog_view_model.dart';

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
      ref.read(enterNewPinForCardUseCaseProvider),
      ref.read(changeDebitPinUseCaseProvider)),
);

///change card pin success view model provider
final changeCardPinSuccessViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ChangeCardPinSuccessPageViewModel, ChangeCardPinSuccessArguments>(
  (ref, args) => ChangeCardPinSuccessPageViewModel(args),
);

///credit card supplementary view model provider
final supplementaryCreditCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<SupplementaryCreditCardPageViewModel>(
  (ref) => SupplementaryCreditCardPageViewModel(),
);

///relationship with card holder view model provider
final relationShipWithCardHolderViewModelProvider =
    ChangeNotifierProvider.autoDispose<RelationshipWithCardholderPageViewModel>(
  (ref) => RelationshipWithCardholderPageViewModel(
      ref.read(relationshipWithCardHolderUseCaseProvider)),
);

///relationship with card holder dialog view model provider
final relationShipWithCardHolderDialogViewModelProvider = ChangeNotifierProvider
    .autoDispose<RelationshipWithCardHolderDialogViewModel>(
  (ref) => RelationshipWithCardHolderDialogViewModel(),
);

///supplementary id scan view model provider
final supplementaryIdScanInfoViewModelProvider = ChangeNotifierProvider
    .autoDispose<SupplementaryIdScanVerificationInfoPageViewModel>(
  (ref) => SupplementaryIdScanVerificationInfoPageViewModel(
      ref.read(idVerificationInfoUseCaseProvider),
      ref.read(scanUserDocumentUseCaseProvider)),
);

///personalize credit card view model provider
final personalizeCreditCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<PersonalizeCreditCardPageViewModel>(
  (ref) => PersonalizeCreditCardPageViewModel(
    ref.read(personalizeCreditCardUseCaseProvider),
  ),
);

///supplementary credit card ready view model provider
final supplementaryCreditCardReadyViewModelProvider = ChangeNotifierProvider
    .autoDispose<SupplementaryCreditCardReadyPageViewModel>(
  (ref) => SupplementaryCreditCardReadyPageViewModel(),
);

///debit card supplementary view model provider
final supplementaryDebitCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<SupplementaryDebitCardPageViewModel>(
  (ref) => SupplementaryDebitCardPageViewModel(),
);

///relationship with card holder debit view model provider
final relationShipWithCardHolderDebitViewModelProvider = ChangeNotifierProvider
    .autoDispose<RelationshipWithCardholderDebitPageViewModel>(
  (ref) => RelationshipWithCardholderDebitPageViewModel(
      ref.read(relationshipWithCardHolderUseCaseProvider)),
);

///supplementary debit id scan view model provider
final supplementaryDebitIdScanInfoViewModelProvider = ChangeNotifierProvider
    .autoDispose<SupplementaryIdScanVerificationInfoDebitPageViewModel>(
  (ref) => SupplementaryIdScanVerificationInfoDebitPageViewModel(
      ref.read(scanUserDocumentUseCaseProvider)),
);

///personalize debit view model provider
final personalizeDebitViewModelProvider =
    ChangeNotifierProvider.autoDispose<PersonalizeDebitCardPageViewModel>(
  (ref) => PersonalizeDebitCardPageViewModel(
      ref.read(personalizeDebitCardUseCaseProvider)),
);

///supplementary card in review view model provider
final supplementaryCardInReviewViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<
        SupplementaryCardInReviewPageViewModel,
        SupplementaryCardInReviewArguments>(
  (ref, args) => SupplementaryCardInReviewPageViewModel(args),
);

///credit card apply success view model provider
final creditCardApplySuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditCardApplySuccessPageViewModel>(
  (ref) => CreditCardApplySuccessPageViewModel(),
);
