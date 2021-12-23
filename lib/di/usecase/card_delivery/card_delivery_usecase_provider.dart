import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/card_delivery/confirm_card_delivery_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_credit_card_delivery_usecase.dart';
import 'package:domain/usecase/card_delivery/confirm_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:domain/usecase/card_delivery/create_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_statement_usecase.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_transactions_usecase.dart';
import 'package:domain/usecase/card_delivery/get_debit_card_transactions_usecase.dart';
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
