import 'package:country_calling_code_picker/picker.dart' as local;
import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:flutter/widgets.dart';

class CountryRepositoryImpl with CountryRepository {
  final CountryLocalDs _localDs;
  final CountryRemoteDs _remoteDs;

  CountryRepositoryImpl(this._localDs, this._remoteDs);

  @override
  Future<Either<LocalError, List<Country>>> fetchCountries(
      {required BuildContext context}) async {
    List<local.Country> countries =
    await _localDs.fetchCountries(context: context);

    if (countries.isNotEmpty) {
      return Right(countries
          .map((e) => Country(
              countryCode: e.countryCode,
              countryFlag: e.flag,
              countryCallingCode: e.callingCode,
              countryName: e.name))
          .toList());
    }
    return Right([]);
  }

  @override
  Future<Either<LocalError, Country>> getCountryByCountryCode(
      {required BuildContext context, String? countryCode}) async {
    local.Country? country = await _localDs.fetchCountryByCountryCode(
        context: context, countryCode: countryCode);

    if (country == null) {
      return Right(Country());
    }

    return Right(Country(
        countryCode: country.countryCode,
        countryFlag: country.flag,
        countryCallingCode: country.callingCode,
        countryName: country.name));
  }

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
  Future<Either<NetworkError, AllowedCountryListResponse>>
  getAllowedCodeCountryList() async {
    final result = await safeApiCall(
      _remoteDs.getAllowedCodeCountryList(),
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
