import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestFromNewRecipientUseCase extends BaseUseCase<NetworkError,
    RequestFromNewRecipientUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required RequestFromNewRecipientUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RequestFromNewRecipientUseCaseParams extends Params {
  String? ibanOrMobile;
  String? purpose;
  String? purposeDetail;

  RequestFromNewRecipientUseCaseParams(
      {this.ibanOrMobile, this.purpose, this.purposeDetail});

  @override
  Either<AppError, bool> verify() {
    if (ibanOrMobile!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_IBAN_MOBILE,
          cause: Exception()));
    } else if (purpose!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PURPOSE,
          cause: Exception()));
    } else if (purposeDetail!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PURPOSE_DETAIL,
          cause: Exception()));
    }
    return Right(true);
  }
}
