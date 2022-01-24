import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EnterAddressUseCase extends BaseUseCase<NetworkError,
    EnterAddressUseCaseParams, SaveCountryResidenceInfoResponse> {
  final UserRepository _repository;

  EnterAddressUseCase(this._repository);

  @override
  Future<Either<NetworkError, SaveCountryResidenceInfoResponse>> execute(
      {required EnterAddressUseCaseParams params}) {
    return _repository.saveResidenceInformation(
        residentCountry: params.countryId,
        //residentArea: params.residentArea,
        residentCity: params.city,
        streetName: params.streetAddress,
        buildingName: params.buildingNameOrNo,
        permanentResidentCountry: params.permanentCountryId,
        permanentResidentCity: params.permanentCityId,
        cityId: params.cityId,
        stateId: params.stateId);
  }
}

class EnterAddressUseCaseParams extends Params {
  final String? residentCountry;

  final String? countryId;
  final String? city;
  final String? streetAddress;
  final String? buildingNameOrNo;
  bool jordanianLivesAbroad;
  final String? permanentResidentCountry;
  final String? permanentCity;
  final String stateId;
  final String cityId;
  final String permanentCityId;
  final String permanentCountryId;

  EnterAddressUseCaseParams(
      {required this.residentCountry,
      required this.countryId,
      this.city,
      required this.streetAddress,
      required this.buildingNameOrNo,
      required this.jordanianLivesAbroad,
      this.permanentCity,
      this.permanentResidentCountry,
      required this.stateId,
      required this.cityId,
      required this.permanentCityId,
      required this.permanentCountryId});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(residentCountry!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_RESIDENT_COUNTRY,
          cause: Exception()));
    } else if (Validator.isEmpty(buildingNameOrNo!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_BUILDING_NAME_OR_NUMBER,
          cause: Exception()));
    } else if (Validator.isEmpty(streetAddress!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_STREET_ADDRESS,
          cause: Exception()));
    } else if (Validator.isEmpty(city!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_CITY,
          cause: Exception()));
    } else if (jordanianLivesAbroad) {
      if (Validator.isEmpty(permanentResidentCountry!)) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.EMPTY_PERMANENT_RESIDENT_COUNTRY,
            cause: Exception()));
      } else if (Validator.isEmpty(permanentCity!)) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.PERMANENT_EMPTY_CITY,
            cause: Exception()));
      }
    }
    return Right(true);
  }
}
