import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/card_delivery/cancel_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_debit_card_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[FreezeDebitCardUseCase] provider
final freezeDebitCardUseCaseProvider =
    Provider.autoDispose<FreezeDebitCardUseCase>(
  (ref) => FreezeDebitCardUseCase(ref.read(cardRepositoryProvider)),
);

///[UnFreezeDebitCardUseCase] provider
final unFreezeDebitCardUseCaseProvider =
    Provider.autoDispose<UnFreezeDebitCardUseCase>(
  (ref) => UnFreezeDebitCardUseCase(ref.read(cardRepositoryProvider)),
);

///[CancelDebitCardUseCase] provider
final cancelDebitCardUseCaseProvider =
    Provider.autoDispose<CancelDebitCardUseCase>(
  (ref) => CancelDebitCardUseCase(ref.read(cardRepositoryProvider)),
);
