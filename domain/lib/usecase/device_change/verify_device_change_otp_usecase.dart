import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/change_device/change_device_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class VerifyDeviceChangeOtpUseCase
    extends BaseUseCase<NetworkError, VerifyDeviceChangeOtpUseCaseParams, bool> {
  final ChangeDeviceRepository _repository;

  VerifyDeviceChangeOtpUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required VerifyDeviceChangeOtpUseCaseParams params}) {
    return _repository.verifyChangeDeviceOtp(otp: params.otp, firebaseToken: params.firebaseToken);
  }
}

class VerifyDeviceChangeOtpUseCaseParams extends Params {
  final String otp;
  final String firebaseToken;

  VerifyDeviceChangeOtpUseCaseParams({required this.otp, required this.firebaseToken});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
