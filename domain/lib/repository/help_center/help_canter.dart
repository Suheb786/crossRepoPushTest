import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class HelpCenterRepository {
  Future<Either<NetworkError, bool>> initInfobip(
      String applicationId, String appKey, String baseUrl,Function(String) callback);

  Future<Either<NetworkError, String>> obtainToken(
      String identity, String displayName);
}
