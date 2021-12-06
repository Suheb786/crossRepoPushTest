import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';

abstract class KYCRepository {
  /// check kyc status of registered user
  Future<Either<NetworkError, CheckKycResponse>> checkKYCStatus(
      {required bool getToken});
}
