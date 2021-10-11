import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class VerifyOtpUseCase
    extends BaseUseCase<LocalError, VerifyOtpUseCaseParams, bool> {
  VerifyOtpUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required VerifyOtpUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class VerifyOtpUseCaseParams extends Params {
  final String otp;

  VerifyOtpUseCaseParams({required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_OTP,
          cause: Exception()));
    }
    return Right(true);
  }
}
