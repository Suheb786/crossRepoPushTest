import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/country/fetch_countries_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchCountriesUseCaseProvider =
    Provider.autoDispose<FetchCountriesUseCase>(
  (ref) => FetchCountriesUseCase(
    ref.read(countryRepoProvider),
  ),
);
