import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/country/get_countries_list_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetCountriesListUseCase] provider
final getCountriesListUseCaseProvider =
    Provider.autoDispose<GetCountriesListUseCase>(
        (ref) => GetCountriesListUseCase(ref.read(countryRepoProvider)));

///[GetAllowedCodeCountryListUseCase] provider
final getAllowedCodeCountriesListUseCaseProvider =
    Provider.autoDispose<GetAllowedCodeCountryListUseCase>((ref) =>
        GetAllowedCodeCountryListUseCase(ref.read(countryRepoProvider)));
