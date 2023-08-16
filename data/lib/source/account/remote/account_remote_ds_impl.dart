import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/account/check_agent_status_request_entity.dart';
import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_call_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_video_call_request.dart';
import 'package:data/entity/remote/account/check_gender_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_request_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_request_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_request_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/account/get_call_status_request.dart';
import 'package:data/entity/remote/account/get_time_slots_request.dart';
import 'package:data/entity/remote/account/get_time_slots_response_entity.dart';
import 'package:data/entity/remote/account/onboarding_mobile_otp_request_entity.dart';
import 'package:data/entity/remote/account/request_call_response_entity.dart';
import 'package:data/entity/remote/account/request_video_call_request.dart';
import 'package:data/entity/remote/account/save_customer_schedule_time_request_entity.dart';
import 'package:data/entity/remote/account/verify_mobile_otp_request_entity.dart';
import 'package:data/entity/remote/account/video_call_status_response_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/account/account_datasource.dart';
import 'package:domain/usecase/account/send_mobile_otp_usecase.dart';
import 'package:domain/usecase/account/verify_mobile_otp_usecase.dart';
import 'package:retrofit/dio.dart';

class AccountRemoteDSImpl extends AccountRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  AccountRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkVideoCallStatus(
        CheckVideoCallStatusRequestEntity(baseData: baseData.toJson(), getToken: getToken));
  }

  @override
  Future<HttpResponse<CheckOtherNationalityStatusResponseEntity>> checkOtherNationalityStatus(
      {bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkOtherNationalityStatus(
        CheckOtherNationalityStatusRequestEntity(baseData: baseData.toJson(), getToken: getToken));
  }

  @override
  Future<HttpResponse<DocStatusResponseEntity>> docStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.docStatus(DocStatusRequestEntity(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<CheckAgentStatusResponseEntity>> checkAgentStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .checkAgentStatus(CheckAgentStatusRequestEntity(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> saveCustomerVideoCallScheduleTime(
      {String? scheduleDate, String? scheduleTime}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveCustomerVideoCallScheduleTime(SaveCustomerScheduleTimeRequestEntity(
        baseData: baseData.toJson(),
        callDate: scheduleDate,
        startTime: scheduleTime,
        gender: "",
        dateToSend: DateTime.now().timeZoneOffset.inMinutes));
  }

  @override
  Future<HttpResponse<CheckExistingCallResponseEntity>> checkExistingCall() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkExistingCall(
      CheckExistingVideoCallRequest(
          baseData: baseData.toJson(), dateToSend: DateTime.now().timeZoneOffset.inMinutes),
    );
  }

  @override
  Future<HttpResponse<CheckGenderResponseEntity>> checkGenderStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkGenderStatus(
      BaseRequest(baseData: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<RequestCallResponseEntity>> requestCall(String? type) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestCall(
      RequestVideoCallRequest(baseData: baseData.toJson(), type: type),
    );
  }

  @override
  Future<HttpResponse<GetTimeSlotsResponseEntity>> getCallTimeSlots(String callDate) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getTimeSlots(
      GetTimeSlotsRequest(
          baseData: baseData.toJson(),
          callDate: callDate,
          dateToSend: DateTime.now().timeZoneOffset.inMinutes),
    );
  }

  @override
  Future<HttpResponse<VideoCallStatusResponseEntity>> getCallStatus(String session) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCallStatus(
      GetCallStatusRequest(baseData: baseData.toJson(), session: session),
    );
  }

  @override
  Future<HttpResponse<ResponseEntity>> sendMobileOTP({required SendMobileOTPUsecaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.sendMobileOTP(OnboardingSendMobileOTPRequestEntity(
        GetToken: params.GetToken,
        MobileNumber: params.MobileNumber,
        MobileCode: params.MobileCode,
        BaseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> verifyMobileOTP(
      {required OnboardingVerifyMobileOtpUsecaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.verifyMobileOTP(OnboardingVerifyMobileOtpRequestEntity(
        OTPCode: params.OTPCode, GetToken: params.GetToken, BaseClass: baseData.toJson()));
  }
}
