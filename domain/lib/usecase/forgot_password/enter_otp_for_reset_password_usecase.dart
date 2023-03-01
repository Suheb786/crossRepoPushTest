import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/forget_password/verify_forget_password_otp_response.dart';
import 'package:domain/repository/forget_password/forget_password_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterOtpForResetPasswordUseCase extends BaseUseCase<NetworkError, EnterOtpForResetPasswordUseCaseParams,
    VerifyForgetPasswordOtpResponse> {
  final ForgetPasswordRepository _repository;

  EnterOtpForResetPasswordUseCase(this._repository);

  @override
  Future<Either<NetworkError, VerifyForgetPasswordOtpResponse>> execute(
      {required EnterOtpForResetPasswordUseCaseParams params}) {
    return _repository.verifyForgetPasswordOtp(
        email: params.email,
        expiryDate: params.idExpiry,
        nationalId: params.idNo,
        createPassword: params.password,
        confirmPassword: params.confirmPassword,
        otp: params.otp);
  }
}

class EnterOtpForResetPasswordUseCaseParams extends Params {
  final String otp;
  final String email;
  final String idNo;
  final String idExpiry;
  final String password;
  final String confirmPassword;

  EnterOtpForResetPasswordUseCaseParams(
      {required this.otp,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.idNo,
      required this.idExpiry});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
