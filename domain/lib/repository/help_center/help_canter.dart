import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/error/network_error.dart';

abstract class HelpCenterRepository {
  Future<Either<NetworkError, bool>> initInfobip(String applicationId,
      String appKey, String baseUrl, Function(InfobipCallStatusEnum) callback);

  Future<Either<NetworkError, String>> obtainToken(
      String identity, String displayName);

  Future<Either<NetworkError, bool>> establishCall();
}
