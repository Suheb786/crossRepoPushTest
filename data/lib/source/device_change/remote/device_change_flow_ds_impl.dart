import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/device_change/resend_otp_device_change_request_entity.dart';
import 'package:data/entity/remote/device_change/send_otp_token_device_change_request_entity.dart';
import 'package:data/entity/remote/device_change/send_otp_token_email_request_entity.dart';
import 'package:data/entity/remote/device_change/verify_device_change_otp_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/device_change/device_change_flow_datasource.dart';
import 'package:retrofit/dio.dart';

class ChangeDeviceRemoteDSImpl extends ChangeDeviceRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  ChangeDeviceRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> resendOtpDeviceChange() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.resendOtpDeviceChange(ResendOtpDeviceChangeRequestEntity(
        baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> sendOtpToken() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.sendOtpToken(SendOtpTokenDeviceChangeRequestEntity(
        baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> sendOtpTokenEmail() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.sendOtpTokenEmail(SendOtpTokenEmailRequestEntity(
        baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> verifyChangeDeviceOtp(
      {required String otp, required String firebaseToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyChangeDeviceOtp(VerifyDeviceChangeOtpRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        otp: otp,
        fireBaseToken: firebaseToken));
  }
}
