import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCityByCountryListUseCase
    extends BaseUseCase<NetworkError, GetCityByCountryListUseParams, CityListResponse> {
  final CountryRepository _countryRepository;

  GetCityByCountryListUseCase(this._countryRepository);

  @override
  Future<Either<NetworkError, CityListResponse>> execute({required GetCityByCountryListUseParams params}) {
    return _countryRepository.getCitiesByCountry(isoCode: params.isoCode, stateID: params.stateId!);
  }
}

class GetCityByCountryListUseParams extends Params {
  final String isoCode;
  final String? stateId;

  GetCityByCountryListUseParams({required this.isoCode, this.stateId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
