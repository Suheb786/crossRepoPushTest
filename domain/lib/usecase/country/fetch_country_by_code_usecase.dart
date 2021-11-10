import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/widgets.dart';

class FetchCountryByCodeUseCase
    extends BaseUseCase<LocalError, FetchCountryByCodeUseCaseParams, Country> {
  final CountryRepository _countryRepository;

  FetchCountryByCodeUseCase(this._countryRepository);

  @override
  Future<Either<LocalError, Country>> execute(
      {required FetchCountryByCodeUseCaseParams params}) {
    return _countryRepository.getCountryByCountryCode(
        context: params.context, countryCode: params.countryCode);
  }
}

class FetchCountryByCodeUseCaseParams extends Params {
  final BuildContext context;
  final String? countryCode;

  FetchCountryByCodeUseCaseParams({required this.context, this.countryCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
