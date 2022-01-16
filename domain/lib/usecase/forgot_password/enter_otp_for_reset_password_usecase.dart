import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterOtpForResetPasswordUseCase extends BaseUseCase<NetworkError,
    EnterOtpForResetPasswordUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required EnterOtpForResetPasswordUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterOtpForResetPasswordUseCaseParams extends Params {
  final String otp;

  EnterOtpForResetPasswordUseCaseParams({required this.otp});

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
