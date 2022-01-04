import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/card_delivery/cancel_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_card_delivery_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_credit_card_delivery_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:domain/usecase/card_delivery/create_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/credit_card_pin_unblock_usecase.dart';
import 'package:domain/usecase/card_delivery/debit_card_limits_update_usecase.dart';
import 'package:domain/usecase/card_delivery/enter_new_pin_for_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_statement_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_statement_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_transactions_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_years_usecase.dart';
import 'package:domain/usecase/card_delivery/get_debit_card_transactions_usecase.dart';
import 'package:domain/usecase/card_delivery/get_debit_years_usecase.dart';
import 'package:domain/usecase/card_delivery/otp_for_change_card_pin_usecase.dart';
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
