import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';

abstract class AccountRepository {
  /// check Video call status
  Future<Either<NetworkError, CheckVideoCallResponse>> checkVideoCallStatus(
      {required bool getToken});
}
