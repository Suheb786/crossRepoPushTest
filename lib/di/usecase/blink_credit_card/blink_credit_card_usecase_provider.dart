import 'package:domain/usecase/blink_credit_card/blink_credit_card_usecase.dart';
import 'package:domain/usecase/credit_card_application_failure/credit_card_application_failure_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[BlinkCreditCardUseCase] provider
final blinkCreditCardUseCaseProvider =
    Provider.autoDispose<BlinkCreditCardUseCase>((ref) => BlinkCreditCardUseCase());

///[CreditCardApplicationFailureUseCase] provider
final creditCardApplicationFailureUseCaseProvider =
    Provider.autoDispose<CreditCardApplicationFailureUseCase>((ref) => CreditCardApplicationFailureUseCase());
