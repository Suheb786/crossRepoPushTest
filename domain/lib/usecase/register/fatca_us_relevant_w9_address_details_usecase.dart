import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FatcaUSRelevantW9AddressDetailsUseCase extends BaseUseCase<LocalError,
    FatcaUSRelevantW9AddressDetailsUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required FatcaUSRelevantW9AddressDetailsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class FatcaUSRelevantW9AddressDetailsUseCaseParams extends Params {
  final String? address;
  final String? state;
  final String? city;
  final String? postCode;
  final String? accountNumber;
  final String? exemptPayeeCode;
  bool isAdditionalRequester;
  final String? additionalRequesterName;
  final String? additionalRequesterAddress;
  final String? additionalRequesterCity;
  final String? additionalRequesterState;
  final String? additionalRequesterPostCode;

  FatcaUSRelevantW9AddressDetailsUseCaseParams(
      {this.address,
      this.city,
      this.accountNumber,
      this.postCode,
      this.state,
      this.exemptPayeeCode,
      required this.isAdditionalRequester,
      this.additionalRequesterAddress,
      this.additionalRequesterCity,
      this.additionalRequesterName,
      this.additionalRequesterPostCode,
      this.additionalRequesterState});

  @override
  Either<AppError, bool> verify() {
    if (address!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_ADDRESS,
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
    } else if (isAdditionalRequester) {
      if (additionalRequesterName!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_REQUESTER_NAME,
            cause: Exception()));
      } else if (additionalRequesterAddress!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_REQUESTER_ADDRESS,
            cause: Exception()));
      } else if (additionalRequesterState!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_REQUESTER_STATE,
            cause: Exception()));
      } else if (additionalRequesterCity!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_REQUESTER_CITY,
            cause: Exception()));
      } else if (additionalRequesterPostCode!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_REQUESTER_POSTCODE,
            cause: Exception()));
      }
    }
    return Right(true);
  }
}
