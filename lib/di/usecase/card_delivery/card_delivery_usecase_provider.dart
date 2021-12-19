import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/card_delivery/confirm_pin_usecase.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:domain/usecase/card_delivery/create_pin_usecase.dart';
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
