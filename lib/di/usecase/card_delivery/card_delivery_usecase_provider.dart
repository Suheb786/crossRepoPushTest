import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/card_delivery/apply_supplementary_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/cancel_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/change_debit_card_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/change_debit_pin_verify_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_card_delivery_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_credit_card_delivery_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:domain/usecase/card_delivery/create_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_pin_unblock_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_request_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limit_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/enter_new_pin_for_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_application_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_statement_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_limit_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_relationship_list_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_statement_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_transactions_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_years_usecase.dart';
import 'package:domain/usecase/card_delivery/get_debit_card_transactions_usecase.dart';
import 'package:domain/usecase/card_delivery/get_debit_years_usecase.dart';
import 'package:domain/usecase/card_delivery/get_loan_values_usecase.dart';
import 'package:domain/usecase/card_delivery/get_supplementary_credit_card_application_usecase.dart';
import 'package:domain/usecase/card_delivery/link_card_step_usecase.dart';
import 'package:domain/usecase/card_delivery/otp_for_change_card_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/personalize_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/personalize_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/relationship_with_card_holder_usecase.dart';
import 'package:domain/usecase/card_delivery/supplementary_credit_card_request_usecase.dart';
import 'package:domain/usecase/card_delivery/supplementary_credit_card_step_three_usecase.dart';
import 'package:domain/usecase/card_delivery/supplementary_credit_card_step_two_usecase.dart';
import 'package:domain/usecase/card_delivery/unblock_debit_card_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_credit_card_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CreatePinUseCase] provider
final createPinUseCaseProvider =
    Provider.autoDispose<CreatePinUseCase>((ref) => CreatePinUseCase());

///[ConfirmPinUseCase] provider
final confirmPinUseCaseProvider = Provider.autoDispose<ConfirmPinUseCase>(
    (ref) => ConfirmPinUseCase(ref.read(cardRepositoryProvider)));

///[CardIssuanceUseCase] provider
final cardIssuanceCaseProvider = Provider.autoDispose<CardIssuanceUseCase>(
    (ref) => CardIssuanceUseCase(ref.read(cardRepositoryProvider)));

///[ConfirmCardDeliveryUseCase] provider
final debitCardConfirmDeliveryCaseProvider =
    Provider.autoDispose<ConfirmCardDeliveryUseCase>(
        (ref) => ConfirmCardDeliveryUseCase(ref.read(cardRepositoryProvider)));

///[GetDebitCardTransactionsUseCase] provider
final debitCardTransactionUseCaseProvider =
    Provider.autoDispose<GetDebitCardTransactionsUseCase>((ref) =>
        GetDebitCardTransactionsUseCase(ref.read(cardRepositoryProvider)));

///[GetCreditCardTransactionsUseCase] provider
final creditCardTransactionUseCaseProvider =
    Provider.autoDispose<GetCreditCardTransactionsUseCase>((ref) =>
        GetCreditCardTransactionsUseCase(ref.read(cardRepositoryProvider)));

///[ConfirmCreditCardDeliveryUseCase] provider
final confirmCreditCardDeliveryUseCaseProvider =
    Provider.autoDispose<ConfirmCreditCardDeliveryUseCase>((ref) =>
        ConfirmCreditCardDeliveryUseCase(ref.read(cardRepositoryProvider)));

///[GetCardStatementUseCase] provider
final cardStatementUseCaseProvider =
    Provider.autoDispose<GetCardStatementUseCase>(
        (ref) => GetCardStatementUseCase(ref.read(cardRepositoryProvider)));

///[GetCreditCardStatementUseCase] provider
final creditCardStatementUseCaseProvider =
    Provider.autoDispose<GetCreditCardStatementUseCase>((ref) =>
        GetCreditCardStatementUseCase(ref.read(cardRepositoryProvider)));

///[GetDebitYearsUseCase] provider
final getDebitYearsUseCaseProvider = Provider.autoDispose<GetDebitYearsUseCase>(
    (ref) => GetDebitYearsUseCase(ref.read(cardRepositoryProvider)));

///[GetCreditYearsUseCase] provider
final getCreditYearsUseCaseProvider =
    Provider.autoDispose<GetCreditYearsUseCase>(
        (ref) => GetCreditYearsUseCase(ref.read(cardRepositoryProvider)));

///[FreezeCreditCardUseCase] provider
final freezeCreditCardUseCaseProvider =
    Provider.autoDispose<FreezeCreditCardUseCase>(
        (ref) => FreezeCreditCardUseCase(ref.read(cardRepositoryProvider)));

///[UnFreezeCreditCardUseCase] provider
final unFreezeCreditCardUseCaseProvider =
    Provider.autoDispose<UnFreezeCreditCardUseCase>(
        (ref) => UnFreezeCreditCardUseCase(ref.read(cardRepositoryProvider)));

///[CancelCreditCardUseCase] provider
final cancelCreditCardUseCaseProvider =
    Provider.autoDispose<CancelCreditCardUseCase>(
        (ref) => CancelCreditCardUseCase(ref.read(cardRepositoryProvider)));

///[UnblockDebitCardPinUseCase] provider
final unBlockDebitCardUseCaseProvider =
    Provider.autoDispose<UnblockDebitCardPinUseCase>(
        (ref) => UnblockDebitCardPinUseCase(ref.read(cardRepositoryProvider)));

///[CreditCardPinUnblockUseCase] provider
final unBlockCreditCardUseCaseProvider =
    Provider.autoDispose<CreditCardPinUnblockUseCase>(
        (ref) => CreditCardPinUnblockUseCase(ref.read(cardRepositoryProvider)));

///[DebitCardLimitsUpdateUseCase] provider
final debitCardLimitsUpdateUseCaseProvider =
    Provider.autoDispose<DebitCardLimitsUpdateUseCase>((ref) =>
        DebitCardLimitsUpdateUseCase(ref.read(cardRepositoryProvider)));

///[DebitCardLimitUseCase] provider
final debitCardLimitUseCaseProvider =
    Provider.autoDispose<DebitCardLimitUseCase>(
        (ref) => DebitCardLimitUseCase(ref.read(cardRepositoryProvider)));

///[CreditCardLimitsUpdateUseCase] provider
final creditCardLimitsUpdateUseCaseProvider =
    Provider.autoDispose<CreditCardLimitsUpdateUseCase>((ref) =>
        CreditCardLimitsUpdateUseCase(ref.read(cardRepositoryProvider)));

///[OtpForChangeCardPinUseCase] provider
final otpForChangeCardPinUseCaseProvider =
    Provider.autoDispose<OtpForChangeCardPinUseCase>(
        (ref) => OtpForChangeCardPinUseCase());

///[EnterNewPinForCardUseCase] provider
final enterNewPinForCardUseCaseProvider =
    Provider.autoDispose<EnterNewPinForCardUseCase>(
        (ref) => EnterNewPinForCardUseCase(ref.read(cardRepositoryProvider)));

///[RelationshipWithCardholderUseCase] provider
final relationshipWithCardHolderUseCaseProvider =
    Provider.autoDispose<RelationshipWithCardholderUseCase>(
        (ref) => RelationshipWithCardholderUseCase());

///[PersonalizeCreditCardUseCase] provider
final personalizeCreditCardUseCaseProvider =
    Provider.autoDispose<PersonalizeCreditCardUseCase>(
        (ref) => PersonalizeCreditCardUseCase());

///[PersonalizeDebitCardUseCase] provider
final personalizeDebitCardUseCaseProvider =
    Provider.autoDispose<PersonalizeDebitCardUseCase>(
        (ref) => PersonalizeDebitCardUseCase());

///[GetCardApplicationUseCase] provider
final getCardApplicationUseCaseProvider =
    Provider.autoDispose<GetCardApplicationUseCase>(
        (ref) => GetCardApplicationUseCase(ref.read(cardRepositoryProvider)));

///[GetLoanValueUseCase] provider
final getLoanValueUseCaseProvider = Provider.autoDispose<GetLoanValueUseCase>(
    (ref) => GetLoanValueUseCase(ref.read(cardRepositoryProvider)));

///[CreditCardRequestUseCase] provider
final creditCardRequestUseCaseProvider =
    Provider.autoDispose<CreditCardRequestUseCase>(
        (ref) => CreditCardRequestUseCase(ref.read(cardRepositoryProvider)));

///[LinkCardStepUseCase] provider
final linkCardStepUseCaseProvider = Provider.autoDispose<LinkCardStepUseCase>(
    (ref) => LinkCardStepUseCase(ref.read(cardRepositoryProvider)));

///[ChangeDebitCardPinUseCase] provider
final changeDebitPinUseCaseProvider =
    Provider.autoDispose<ChangeDebitCardPinUseCase>(
        (ref) => ChangeDebitCardPinUseCase(ref.read(cardRepositoryProvider)));

///[ChangeDebitPinVerifyUseCase] provider
final changeDebitPinVerifyUseCaseProvider =
    Provider.autoDispose<ChangeDebitPinVerifyUseCase>(
        (ref) => ChangeDebitPinVerifyUseCase(ref.read(cardRepositoryProvider)));

///[ApplySupplementaryDebitCardUseCase] provider
final applySupplementaryDebitUseCaseProvider =
    Provider.autoDispose<ApplySupplementaryDebitCardUseCase>((ref) =>
        ApplySupplementaryDebitCardUseCase(ref.read(cardRepositoryProvider)));

///[GetCreditCardRelationshipListUseCase] provider
final getCreditCardRelationshipUseCaseProvider =
    Provider.autoDispose<GetCreditCardRelationshipListUseCase>((ref) =>
        GetCreditCardRelationshipListUseCase(ref.read(cardRepositoryProvider)));

///[GetSupplementaryCreditCardApplicationUseCase] provider
final getSupplementaryCreditCardApplicationUseCaseProvider =
    Provider.autoDispose<GetSupplementaryCreditCardApplicationUseCase>((ref) =>
        GetSupplementaryCreditCardApplicationUseCase(
            ref.read(cardRepositoryProvider)));

///[SupplementaryCreditCardRequestUseCase] provider
final supplementaryCreditCardRequestUseCaseProvider =
    Provider.autoDispose<SupplementaryCreditCardRequestUseCase>((ref) =>
        SupplementaryCreditCardRequestUseCase(
            ref.read(cardRepositoryProvider)));

///[SupplementaryCreditCardStepTwoUseCase] provider
final supplementaryCreditCardStepTwoUseCaseProvider =
    Provider.autoDispose<SupplementaryCreditCardStepTwoUseCase>((ref) =>
        SupplementaryCreditCardStepTwoUseCase(
            ref.read(cardRepositoryProvider)));

///[SupplementaryCreditCardStepThreeUseCase] provider
final supplementaryCreditCardStepThreeUseCaseProvider =
    Provider.autoDispose<SupplementaryCreditCardStepThreeUseCase>((ref) =>
        SupplementaryCreditCardStepThreeUseCase(
            ref.read(cardRepositoryProvider)));

///[GetCreditCardLimitUseCase] provider
final getCreditCardLimitUseCaseProvider =
    Provider.autoDispose<GetCreditCardLimitUseCase>(
        (ref) => GetCreditCardLimitUseCase(ref.read(cardRepositoryProvider)));
