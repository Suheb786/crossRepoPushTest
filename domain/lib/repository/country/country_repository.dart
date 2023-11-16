import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/country/state_list/state_list_response.dart';

mixin CountryRepository {
  Future<Either<NetworkError, CountryListContentData>> getCountryList();

  Future<Either<NetworkError, StateListResponse>> getStateList({String isoCode});

  Future<Either<NetworkError, CityListResponse>> getCityList({String stateID, String isoCode});

  Future<Either<NetworkError, CityListResponse>> getCitiesByCountry({String stateID, String isoCode});

  Future<Either<NetworkError, AllowedCountryListResponse>> getAllowedCodeCountryList();

  Future<Either<NetworkError, List<AllowedIssuerCountry>>> fetchAllowedIssuers();
}
