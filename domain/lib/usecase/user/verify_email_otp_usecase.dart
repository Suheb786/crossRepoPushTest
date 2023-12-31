import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class VerifyEmailOtpUseCase extends BaseUseCase<NetworkError, VerifyEmailOtpUseCaseParams, bool> {
  final UserRepository _repository;

  VerifyEmailOtpUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required VerifyEmailOtpUseCaseParams params}) {
    return _repository.verifyEmailOTP(otpCode: params.otp, email: params.email);
  }
}

class VerifyEmailOtpUseCaseParams extends Params {
  final String otp;
  final String email;

  VerifyEmailOtpUseCaseParams({required this.email, required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
