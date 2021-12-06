import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_agent_status_response.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/model/account/doc_status_response.dart';

abstract class AccountRepository {
  /// check Video call status
  Future<Either<NetworkError, CheckVideoCallResponse>> checkVideoCallStatus(
      {required bool getToken});

  /// check other nationality status
  Future<Either<NetworkError, CheckOtherNationalityResponse>>
      checkOtherNationalityStatus({required bool getToken});

  /// check document status
  Future<Either<NetworkError, DocStatusResponse>> docStatus();

  /// check agent status
  Future<Either<NetworkError, CheckAgentStatusResponse>> checkAgentStatus();
}
