import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/forget_password/forget_password_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:domain/model/forget_password/forget_password_response.dart';
import 'package:domain/model/forget_password/verify_forget_password_otp_response.dart';
import 'package:domain/repository/forget_password/forget_password_repository.dart';

class ForgetPasswordRepositoryImpl extends ForgetPasswordRepository {
  final ForgetPasswordRemoteDs _remoteDs;

  ForgetPasswordRepositoryImpl(this._remoteDs);

  @override
  Future<Either<NetworkError, CheckForgetPasswordResponse>> checkForgetPassword(
      {required String? email, required String? expiryDate, required String? nationalId}) async {
    final result = await safeApiCall(
      _remoteDs.checkForgetPassword(email: email, expiryDate: expiryDate, nationalId: nationalId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, ForgetPasswordResponse>> resetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword}) async {
    final result = await safeApiCall(
      _remoteDs.resetPassword(
          email: email,
          expiryDate: expiryDate,
          nationalId: nationalId,
          confirmPassword: confirmPassword,
          createPassword: createPassword),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, VerifyForgetPasswordOtpResponse>> verifyForgetPasswordOtp(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword,
      required String? otp}) async {
    final result = await safeApiCall(
      _remoteDs.verifyForgetPasswordOtp(
          email: email,
          expiryDate: expiryDate,
          nationalId: nationalId,
          createPassword: createPassword,
          confirmPassword: confirmPassword,
          otp: otp),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
