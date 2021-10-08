import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchCountriesUseCaseProvider =
    Provider.autoDispose<FetchCountriesUseCase>(
  (ref) => FetchCountriesUseCase(
    ref.read(countryRepoProvider),
  ),
);

final registerNumberUseCaseProvider =
    Provider.autoDispose<RegisterNumberUseCase>(
  (ref) => RegisterNumberUseCase(),
);
