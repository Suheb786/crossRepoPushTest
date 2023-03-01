import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/country/get_cities_by_country_usecase.dart';
import 'package:domain/usecase/country/get_city_list_usecase.dart';
import 'package:domain/usecase/country/get_countries_list_usecase.dart';
import 'package:domain/usecase/country/get_state_list_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetCountriesListUseCase] provider
final getCountriesListUseCaseProvider = Provider.autoDispose<GetCountriesListUseCase>(
    (ref) => GetCountriesListUseCase(ref.read(countryRepoProvider)));

///[GetAllowedCodeCountryListUseCase] provider
final getAllowedCodeCountriesListUseCaseProvider = Provider.autoDispose<GetAllowedCodeCountryListUseCase>(
    (ref) => GetAllowedCodeCountryListUseCase(ref.read(countryRepoProvider)));

///[GetCityByCountryListUseCase] provider
final getCitiesByCountryListUseCaseProvider = Provider.autoDispose<GetCityByCountryListUseCase>(
    (ref) => GetCityByCountryListUseCase(ref.read(countryRepoProvider)));

///[GetStateListUseCase] provider
final getStateListUseCaseProvider =
    Provider.autoDispose<GetStateListUseCase>((ref) => GetStateListUseCase(ref.read(countryRepoProvider)));

///[GetCityListUseCase] provider
final getCityListUseCaseProvider =
    Provider.autoDispose<GetCityListUseCase>((ref) => GetCityListUseCase(ref.read(countryRepoProvider)));
