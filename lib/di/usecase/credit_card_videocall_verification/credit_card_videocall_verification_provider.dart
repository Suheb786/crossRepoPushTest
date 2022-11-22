import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/credit_card_videocall_verification/credit_card_call_status_update_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CreditCardCallStatusUpdateUseCaseProvider] provider
final creditCardCallStatusUpdateUseCaseProvider = Provider.autoDispose<CreditCardCallStatusUpdateUseCase>(
    (ref) => CreditCardCallStatusUpdateUseCase(ref.read(cardRepositoryProvider)));
