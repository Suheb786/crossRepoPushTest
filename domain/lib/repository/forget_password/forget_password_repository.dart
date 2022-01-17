import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';

abstract class ForgetPasswordRepository {
  Future<Either<NetworkError, CheckForgetPasswordResponse>> checkForgetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId});
}
