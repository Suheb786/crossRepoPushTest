import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/country/state_list/state_list_response.dart';
import 'package:domain/repository/country/country_repository.dart';

class CountryRepositoryImpl with CountryRepository {
  final CountryRemoteDs _remoteDs;

  CountryRepositoryImpl(this._remoteDs);

  @override
  Future<Either<NetworkError, CountryListContentData>> getCountryList() async {
    final result = await safeApiCall(
      _remoteDs.getCountryList(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, AllowedCountryListResponse>> getAllowedCodeCountryList() async {
    final result = await safeApiCall(
      _remoteDs.getAllowedCodeCountryList(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, StateListResponse>> getStateList({String? isoCode}) async {
    final result = await safeApiCall(
      _remoteDs.getStateList(isoCode: isoCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CityListResponse>> getCityList({String? stateID, String? isoCode}) async {
    final result = await safeApiCall(
      _remoteDs.getCityList(stateID: stateID, isoCode: isoCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CityListResponse>> getCitiesByCountry(
      {String? stateID, String? isoCode}) async {
    final result = await safeApiCall(
      _remoteDs.getCitiesByCountry(stateID: stateID, isoCode: isoCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<AllowedIssuerCountry>>> fetchAllowedIssuers() async {
    final result = await safeApiCall(
      _remoteDs.fetchAllowedIssuers(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
