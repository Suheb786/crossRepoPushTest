import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/register/get_occupation_list_usecase.dart';
import 'package:domain/usecase/register/get_purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetOccupationUseCase] provider
final getOccupationUseCaseProvider = Provider.autoDispose<GetOccupationUseCase>(
  (ref) => GetOccupationUseCase(ref.read(registerRepoProvider)),
);

///[GetPurposeOfAccountOpeningUseCase] provider
final purposeOfAccountOpeningUseCaseProvider =
    Provider.autoDispose<GetPurposeOfAccountOpeningUseCase>(
  (ref) => GetPurposeOfAccountOpeningUseCase(ref.read(registerRepoProvider)),
);

///[GetAdditionalIncomeSourceUseCase] provider
final additionalIncomeSourceUseCaseProvider =
    Provider.autoDispose<GetAdditionalIncomeSourceUseCase>(
  (ref) => GetAdditionalIncomeSourceUseCase(ref.read(registerRepoProvider)),
);
