import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCountriesListUseCase
    extends BaseUseCase<NetworkError, GetCountriesListUseCaseParams, CountryListContentData> {
  final CountryRepository _countryRepository;

  GetCountriesListUseCase(this._countryRepository);

  @override
  Future<Either<NetworkError, CountryListContentData>> execute(
      {required GetCountriesListUseCaseParams params}) {
    return _countryRepository.getCountryList();
  }
}

class GetCountriesListUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
