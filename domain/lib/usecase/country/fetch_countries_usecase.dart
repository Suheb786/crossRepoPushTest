import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/widgets.dart';

class FetchCountriesUseCase
    extends BaseUseCase<LocalError, FetchCountriesUseParams, List<Country>> {
  final CountryRepository _countryRepository;

  FetchCountriesUseCase(this._countryRepository);

  @override
  Future<Either<LocalError, List<Country>>> execute(
      {required FetchCountriesUseParams params}) {
    return _countryRepository.fetchCountries(context: params.context);
  }
}

class FetchCountriesUseParams extends Params {
  final BuildContext context;

  FetchCountriesUseParams({required this.context});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
