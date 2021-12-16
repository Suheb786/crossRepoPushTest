import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FatcaUSRelevantW8AddressDetailsUseCase extends BaseUseCase<LocalError,
    FatcaUSRelevantW8AddressDetailsUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required FatcaUSRelevantW8AddressDetailsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class FatcaUSRelevantW8AddressDetailsUseCaseParams extends Params {
  final String? permanentAddress;
  final String? country;
  final String? state;
  final String? city;
  final String? postCode;
  final bool isMailingAddressDifferent;
  final String? differentAddress;
  final String? differentCountry;
  final String? differentState;
  final String? differentCity;
  final String? differentPostCode;

  FatcaUSRelevantW8AddressDetailsUseCaseParams(
      {this.permanentAddress,
      this.city,
      this.country,
      this.postCode,
      this.state,
      this.differentAddress,
      this.differentCity,
      this.differentCountry,
      this.differentPostCode,
      this.differentState,
      required this.isMailingAddressDifferent});

  @override
  Either<AppError, bool> verify() {
    if (permanentAddress!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_PERMANENT_ADDRESS_LINE,
          cause: Exception()));
    } else if (country!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_COUNTRY,
          cause: Exception()));
    } else if (state!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_STATE,
          cause: Exception()));
    } else if (city!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_CITY,
          cause: Exception()));
    } else if (postCode!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_POSTCODE,
          cause: Exception()));
    } else if (isMailingAddressDifferent) {
      if (differentAddress!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.DIFFERENT_ADDRESS_LINE,
            cause: Exception()));
      } else if (differentCountry!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.DIFFERENT_COUNTRY,
            cause: Exception()));
      } else if (differentState!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.DIFFERENT_STATE,
            cause: Exception()));
      } else if (differentCity!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.DIFFERENT_CITY,
            cause: Exception()));
      } else if (differentPostCode!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.DIFFERENT_POSTCODE,
            cause: Exception()));
      }
    }
    return Right(true);
  }
}
