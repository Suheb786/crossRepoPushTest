import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FetchAllowedIssuersUseCase
    extends BaseUseCase<NetworkError, FetchAllowedIssuersUseCaseParams, List<AllowedIssuerCountry>> {
  final CountryRepository _countryRepository;

  FetchAllowedIssuersUseCase(this._countryRepository);

  @override
  Future<Either<NetworkError, List<AllowedIssuerCountry>>> execute(
      {required FetchAllowedIssuersUseCaseParams params}) {
    return _countryRepository.fetchAllowedIssuers();
  }
}

class FetchAllowedIssuersUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
