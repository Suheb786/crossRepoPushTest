import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class CliqRepository {
  Future<Either<NetworkError, bool>> editCliqID({
    required bool isAlias,
    required String aliasId,
    required String aliasValue,
    required String OtpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> suspendCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> reActivateCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> deleteCliqId({
    required String aliasId,
    required bool getToken,
  });
}
