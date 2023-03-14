import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/accountsettings/change_email_request.dart';
import 'package:data/entity/remote/accountsettings/change_mobile_request.dart';
import 'package:data/entity/remote/accountsettings/change_password_request.dart';
import 'package:data/entity/remote/accountsettings/get_customer_doc_id_response_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_request_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_changed_success_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_details_response_entity.dart';
import 'package:data/entity/remote/accountsettings/update_profile_image_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_email_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_mobile_request_entity.dart';
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
  Future<HttpResponse<ResponseEntity>> changeEmail({required String email}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeEmail(ChangeEmailRequest(baseData: baseData.toJson(), email: email));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeMobile(
      {required String mobile, required String mobileCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeMobile(
        ChangeMobileRequest(baseData: baseData.toJson(), mobile: mobile, mobileCode: mobileCode));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changePassword(
      {required String oldPassword, required String newPassword, required String confirmNewPassword}) async {
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
    return _apiService.getProfileDetails(BaseRequest(baseData: baseData.toJson(), getToken: false));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateProfileImage({required String filePath}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateProfileImage(
        UpdateProfileImageRequest(baseData: baseData.toJson(), image: ImageUtils.convertToBase64(filePath)));
  }

  @override
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeEmail({required String otp}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyChangeEmail(VerifyChangeEmailRequest(
        baseData: baseData.toJson(), otp: otp, uniqueId: DateTime.now().microsecondsSinceEpoch.toString()));
  }

  @override
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeMobile(
      {required String otp, required String mobileNo, required String mobileCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyChangeMobile(VerifyChangeMobileRequestEntity(
        baseData: baseData.toJson(),
        otp: otp,
        mobileCode: mobileCode,
        mobileNo: mobileNo,
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> deleteProfileImage() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteProfileImage(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetCustomerDocIdResponseEntity>> getCustomerDocId() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCustomerDocId(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetCustomerDocumentResponseEntity>> getCustomerDocument({String? docId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCustomerDocument(
        GetCustomerDocumentRequestEntity(baseData: baseData.toJson(), docId: docId!, getToken: true));
  }
}
