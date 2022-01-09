import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/state_list/state_list_response.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetStateListUseCase extends BaseUseCase<NetworkError,
    GetStateListUseParams, StateListResponse> {
  final CountryRepository _countryRepository;

  GetStateListUseCase(this._countryRepository);

  @override
  Future<Either<NetworkError, StateListResponse>> execute(
      {required GetStateListUseParams params}) {
    return _countryRepository.getStateList(isoCode: params.isoCode);
  }
}

class GetStateListUseParams extends Params {
  final String isoCode;

  GetStateListUseParams({required this.isoCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
