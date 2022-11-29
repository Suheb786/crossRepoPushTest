import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:domain/model/forget_password/forget_password_response.dart';
import 'package:domain/model/forget_password/verify_forget_password_otp_response.dart';

abstract class ForgetPasswordRepository {
  Future<Either<NetworkError, CheckForgetPasswordResponse>> checkForgetPassword(
      {required String? email, required String? expiryDate, required String? nationalId});

  Future<Either<NetworkError, ForgetPasswordResponse>> resetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword});

  Future<Either<NetworkError, VerifyForgetPasswordOtpResponse>> verifyForgetPasswordOtp(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword,
      required String? otp});
}
