import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class KYCRepository {
  /// check kyc status of registered user
  Future<Either<NetworkError, String>> checkKYCStatus({required bool getToken});
}
