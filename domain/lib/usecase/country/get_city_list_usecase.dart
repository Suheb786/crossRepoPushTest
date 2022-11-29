import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCityListUseCase extends BaseUseCase<NetworkError, GetCityListUseParams, CityListResponse> {
  final CountryRepository _countryRepository;

  GetCityListUseCase(this._countryRepository);

  @override
  Future<Either<NetworkError, CityListResponse>> execute({required GetCityListUseParams params}) {
    return _countryRepository.getCityList(isoCode: params.isoCode, stateID: params.stateID);
  }
}

class GetCityListUseParams extends Params {
  final String isoCode;
  final String stateID;

  GetCityListUseParams({required this.isoCode, required this.stateID});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
