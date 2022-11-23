import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_request_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/forget_password/forget_password_datasource.dart';
import 'package:retrofit/dio.dart';

class ForgetPasswordRemoteDsImpl extends ForgetPasswordRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  ForgetPasswordRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CheckForgetPasswordResponseEntity>> checkForgetPassword(
      {required String? email, required String? expiryDate, required String? nationalId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkForgetPassword(CheckForgetPasswordRequestEntity(
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
        email: email,
        idNo: nationalId,
        idExpiry: expiryDate,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ForgetPasswordResponseEntity>> resetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.resetPassword(ForgetPasswordRequestEntity(
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
        email: email,
        idNo: nationalId,
        idExpiry: expiryDate,
        password: createPassword,
        reEnterPassword: confirmPassword,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<VerifyForgetPasswordOtpResponseEntity>> verifyForgetPasswordOtp(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword,
      required String? otp}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyForgetPasswordOtp(VerifyForgetPasswordOtpRequestEntity(
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
        email: email,
        idNo: nationalId,
        idExpiry: expiryDate,
        password: createPassword,
        reEnterPassword: confirmPassword,
        otp: otp,
        baseData: baseData.toJson()));
  }
}
