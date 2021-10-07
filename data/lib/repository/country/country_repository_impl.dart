import 'package:country_calling_code_picker/picker.dart' as local;
import 'package:dartz/dartz.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:flutter/widgets.dart';

class CountryRepositoryImpl with CountryRepository {
  final CountryLocalDs _localDs;

  CountryRepositoryImpl(this._localDs);

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
}
