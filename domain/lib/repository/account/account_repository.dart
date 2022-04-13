import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/available_time_slots.dart';
import 'package:domain/model/account/check_agent_status_response.dart';
import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/model/account/doc_status_response.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/model/account/video_kyc_status.dart';

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

  /// save customer schedule time
  Future<Either<NetworkError, bool>> saveCustomerVideoCallScheduleTime(
      {required String scheduleDate, required String scheduleTime});

  /// Check whether call is existing or scheduled already
  Future<Either<NetworkError, CheckExistingCallStatus>> checkExistingCall();

  /// Check for wether agent available or not
  Future<Either<NetworkError, AgentGenderStatus>> checkGenderStatus();

  /// Request New Call
  Future<Either<NetworkError, RequestCallStatus>> requestCall(String? type);

  Future<Either<NetworkError, List<AvailableTimeSlots>>> getCallTimeSlots(
      String callDate);

  Future<Either<NetworkError, VideoKycStatus>> getCallStatus(String session);
}
