import 'package:data/di/local_module.dart';
import 'package:data/repository/country/country_repository_impl.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:riverpod/riverpod.dart';

/// inject [CountryRepository] provider
var countryRepoProvider = Provider<CountryRepository>(
  (ref) => CountryRepositoryImpl(
    ref.read(countryLocalDataProvider),
  ),
);
