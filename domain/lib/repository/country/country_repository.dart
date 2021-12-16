import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:flutter/widgets.dart';

mixin CountryRepository {
  Future<Either<LocalError, List<Country>>> fetchCountries(
      {required BuildContext context});

  Future<Either<LocalError, Country>> getCountryByCountryCode(
      {required BuildContext context, String? countryCode});

  Future<Either<NetworkError, CountryListContentData>> getCountryList();

  Future<Either<NetworkError, AllowedCountryListResponse>>
      getAllowedCodeCountryList();
}
