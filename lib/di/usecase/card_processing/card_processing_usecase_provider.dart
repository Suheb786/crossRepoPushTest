import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/card_processing/decrypt_card_use_case.dart';
import 'package:domain/usecase/card_processing/generate_block_pin_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GenerateBlockPinUseCase] provider
final getGenerateBlockPinUseCaseProvider =
    Provider.autoDispose<GenerateBlockPinUseCase>(
        (ref) => GenerateBlockPinUseCase(ref.read(cardProcessingRepository)));

///[DecryptCardUseCase] provider
final getDecryptedCardNumberUseCaseProvider =
    Provider.autoDispose<DecryptCardUseCase>(
        (ref) => DecryptCardUseCase(ref.read(cardProcessingRepository)));
