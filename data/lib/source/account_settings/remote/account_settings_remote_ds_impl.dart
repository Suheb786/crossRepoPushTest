import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/accountsettings/change_email_request.dart';
import 'package:data/entity/remote/accountsettings/change_mobile_request.dart';
import 'package:data/entity/remote/accountsettings/change_password_request.dart';
import 'package:data/entity/remote/accountsettings/profile_details_response_entity.dart';
import 'package:data/entity/remote/accountsettings/update_profile_image_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_email_request.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/account_settings/account_settings_datasource.dart';
import 'package:retrofit/dio.dart';

class AccountSettingsRemoteDsImpl extends AccountSettingsRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  AccountSettingsRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> changeEmail(
      {required String email}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeEmail(
        ChangeEmailRequest(baseData: baseData.toJson(), email: email));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeMobile(
      {required String mobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeMobile(
        ChangeMobileRequest(baseData: baseData.toJson(), mobile: mobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changePassword(ChangePasswordRequest(
        baseData: baseData.toJson(),
        getToken: true,
        confirmPassword: confirmNewPassword,
        newPassword: newPassword,
        currentPassword: oldPassword));
  }

  @override
  Future<HttpResponse<ProfileDetailsResponseEntity>> getAccountDetails() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getProfileDetails(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateProfileImage(
      {required String filePath}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateProfileImage(UpdateProfileImageRequest(
        baseData: baseData.toJson(),
        image: ImageUtils.convertToBase64(filePath)));
  }

  @override
  Future<HttpResponse<ResponseEntity>> verifyChangeEmail(
      {required String otp}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyChangeEmail(VerifyChangeEmailRequest(
        baseData: baseData.toJson(),
        otp: otp,
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> verifyChangeMobile(
      {required String otp}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyChangeMobile(VerifyChangeEmailRequest(
        baseData: baseData.toJson(),
        otp: otp,
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString()));
  }
}
