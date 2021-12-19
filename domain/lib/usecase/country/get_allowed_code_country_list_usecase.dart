import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAllowedCodeCountryListUseCase extends BaseUseCase<NetworkError,
    GetAllowedCodeCountryListUseCaseParams,
    AllowedCountryListResponse> {
  final CountryRepository _countryRepository;

  GetAllowedCodeCountryListUseCase(this._countryRepository);

  @override
  Future<Either<NetworkError, AllowedCountryListResponse>> execute(
      {required GetAllowedCodeCountryListUseCaseParams params}) {
    return _countryRepository.getAllowedCodeCountryList();
  }
}

class GetAllowedCodeCountryListUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
