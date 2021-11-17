import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/bank_smart/purpose_of_account_opening_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[PurposeOfAccountOpeningUseCase] provider
final purposeOfAccountsOpeningUseCaseProvider =
    Provider.autoDispose<PurposeOfAccountOpeningUseCase>(
        (ref) => PurposeOfAccountOpeningUseCase(
          ref.read(bankSmartRepositoryProvider)
        ));
