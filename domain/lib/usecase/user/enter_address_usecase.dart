import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

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

  EnterAddressUseCaseParams(
      {required this.residentCountry,
      required this.homeAddress,
      required this.streetAddress,
      required this.buildingNameOrNo});

  @override
  Either<AppError, bool> verify() {
    if(residentCountry!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_RESIDENT_COUNTRY,
          cause: Exception()));
    } else if(homeAddress!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_HOME_ADDRESS,
          cause: Exception()));
    } else if(streetAddress!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_STREET_ADDRESS,
          cause: Exception()));
    } else if(buildingNameOrNo!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_BUILDING_NAME_OR_NUMBER,
          cause: Exception()));
    }
    return Right(true);
  }
}
