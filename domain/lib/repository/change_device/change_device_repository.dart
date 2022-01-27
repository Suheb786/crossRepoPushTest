import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class ChangeDeviceRepository {
  Future<Either<NetworkError, bool>> sendOtpTokenEmail();

  Future<Either<NetworkError, bool>> sendOtpToken();

  Future<Either<NetworkError, bool>> verifyChangeDeviceOtp(
      {required String otp, required String firebaseToken});

  Future<Either<NetworkError, bool>> resendOtpDeviceChange();
}
