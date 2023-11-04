import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_call_response_entity.dart';
import 'package:data/entity/remote/account/check_gender_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/account/get_time_slots_response_entity.dart';
import 'package:data/entity/remote/account/request_call_response_entity.dart';
import 'package:data/entity/remote/account/video_call_status_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:domain/usecase/account/send_mobile_otp_usecase.dart';
import 'package:domain/usecase/account/verify_mobile_otp_usecase.dart';

abstract class AccountRemoteDS {
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus({bool getToken});

  Future<HttpResponse<CheckOtherNationalityStatusResponseEntity>> checkOtherNationalityStatus(
      {bool getToken});

  Future<HttpResponse<DocStatusResponseEntity>> docStatus();

  Future<HttpResponse<CheckAgentStatusResponseEntity>> checkAgentStatus();

  Future<HttpResponse<ResponseEntity>> saveCustomerVideoCallScheduleTime(
      {String scheduleDate, String scheduleTime});

  Future<HttpResponse<CheckExistingCallResponseEntity>> checkExistingCall();

  Future<HttpResponse<CheckGenderResponseEntity>> checkGenderStatus();

  Future<HttpResponse<RequestCallResponseEntity>> requestCall(String? type);

  Future<HttpResponse<GetTimeSlotsResponseEntity>> getCallTimeSlots(String callDate);

  Future<HttpResponse<VideoCallStatusResponseEntity>> getCallStatus(String session);
  Future<HttpResponse<ResponseEntity>> sendMobileOTP({required SendMobileOTPUsecaseParams params});
  Future<HttpResponse<ResponseEntity>> verifyMobileOTP(
      {required OnboardingVerifyMobileOtpUsecaseParams params});
}

abstract class AccountLocalDS {}
