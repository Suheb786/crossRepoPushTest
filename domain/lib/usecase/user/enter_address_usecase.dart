import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EnterAddressUseCase
    extends BaseUseCase<LocalError, EnterAddressUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required EnterAddressUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterAddressUseCaseParams extends Params {
  final String? residentCountry;
  final String? homeAddress;
  final String? streetAddress;
  final String? buildingNameOrNo;
  bool jordanianLivesAbroad;
  final String? permanentResidentCountry;
  final String? permanentCity;

  EnterAddressUseCaseParams(
      {required this.residentCountry,
      required this.homeAddress,
      required this.streetAddress,
      required this.buildingNameOrNo,
      required this.jordanianLivesAbroad,
      this.permanentCity,
      this.permanentResidentCountry});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(residentCountry!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_RESIDENT_COUNTRY,
          cause: Exception()));
    } else if (Validator.isEmpty(homeAddress!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_HOME_ADDRESS,
          cause: Exception()));
    } else if (Validator.isEmpty(streetAddress!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_STREET_ADDRESS,
          cause: Exception()));
    } else if (Validator.isEmpty(buildingNameOrNo!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_BUILDING_NAME_OR_NUMBER,
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
            type: ErrorType.EMPTY_CITY,
            cause: Exception()));
      }
    }
    return Right(true);
  }
}
