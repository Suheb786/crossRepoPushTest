import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/debit_card_replacement/confirm_replacement_pin_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[ConfirmReplacementPinUseCase] provider
final confirmReplacementPinUseCaseProvider = Provider.autoDispose<ConfirmReplacementPinUseCase>(
  (ref) => ConfirmReplacementPinUseCase(ref.read(cardRepositoryProvider)),
);
