import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/forget_password/forget_password_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:domain/repository/forget_password/forget_password_repository.dart';

class ForgetPasswordRepositoryImpl extends ForgetPasswordRepository {
  final ForgetPasswordRemoteDs _remoteDs;

  ForgetPasswordRepositoryImpl(this._remoteDs);

  @override
  Future<Either<NetworkError, CheckForgetPasswordResponse>> checkForgetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId}) async {
    final result = await safeApiCall(
      _remoteDs.checkForgetPassword(
          email: email, expiryDate: expiryDate, nationalId: nationalId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
