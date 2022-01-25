import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/account/account_datasource.dart';
import 'package:domain/constants/enum/video_kyc_status_enum.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/check_agent_status_response.dart';
import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/model/account/doc_status_response.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/model/account/save_customer_schedule_time_response.dart';
import 'package:domain/model/account/video_kyc_status.dart';
import 'package:domain/repository/account/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountRemoteDS _accountRemoteDS;

  AccountRepositoryImpl(this._accountRemoteDS);

  @override
  Future<Either<NetworkError, CheckVideoCallResponse>> checkVideoCallStatus(
      {required bool getToken}) async {
    final result = await safeApiCall(
      _accountRemoteDS.checkVideoCallStatus(getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckOtherNationalityResponse>>
      checkOtherNationalityStatus({required bool getToken}) async {
    final result = await safeApiCall(
      _accountRemoteDS.checkOtherNationalityStatus(getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, DocStatusResponse>> docStatus() async {
    final result = await safeApiCall(
      _accountRemoteDS.docStatus(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckAgentStatusResponse>>
      checkAgentStatus() async {
    final result = await safeApiCall(
      _accountRemoteDS.checkAgentStatus(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, SaveCustomerScheduleTimeResponse>>
      saveCustomerVideoCallScheduleTime(
          {required String scheduleDate, required String scheduleTime}) async {
    final result = await safeApiCall(
      _accountRemoteDS.saveCustomerVideoCallScheduleTime(
          scheduleDate: scheduleDate, scheduleTime: scheduleTime),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckExistingCallStatus>>
      checkExistingCall() async {
    final result = await safeApiCall(
      _accountRemoteDS.checkExistingCall(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, AgentGenderStatus>> checkGenderStatus() async {
    final result = await safeApiCall(
      _accountRemoteDS.checkGenderStatus(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, RequestCallStatus>> requestCall() async {
    final result = await safeApiCall(
      _accountRemoteDS.requestCall(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<String>>> getCallTimeSlots(
      String callDate) async {
    final result = await safeApiCall(
      _accountRemoteDS.getCallTimeSlots(callDate),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, VideoKycStatus>> getCallStatus(
      String session) async {
    final result = await safeApiCall(
      _accountRemoteDS.getCallStatus(session),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(
          VideoKycStatus(status: (r.data.content as String).fromStatusValue())),
    );
  }
}
