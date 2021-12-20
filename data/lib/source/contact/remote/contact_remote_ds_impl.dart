import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/contact/add_beneficiary_request.dart';
import 'package:data/entity/remote/contact/delete_beneficiary_request.dart';
import 'package:data/entity/remote/contact/update_beneficiary_request.dart';
import 'package:data/entity/remote/contact/upload_beneficiary_image_request.dart';
import 'package:data/entity/remote/contact/verify_beneficiary_otp_request.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/contact/contact_data_source.dart';
import 'package:retrofit/dio.dart';

class ContactRemoteDsImpl extends ContactRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  ContactRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> addBeneficiary(
      {String? nickName,
      String? fullName,
      String? accountNumber,
      String? iBan,
      String? bankName,
      String? purpose,
      String? purposeDetails,
      String? imageFilePath}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addBeneficiary(AddBeneficiaryRequest(
        image: ImageUtils.convertToBase64(imageFilePath!),
        accountNo: accountNumber,
        bankName: bankName,
        fullName: fullName,
        iBan: iBan,
        nickName: nickName,
        purpose: purpose,
        purposeDetails: purposeDetails,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> deleteBeneficiary(
      {String? beneficiaryId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteBeneficiary(DeleteBeneficiaryRequest(
        beneficiaryId: beneficiaryId!, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getBeneficiaries() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getBeneficiaries(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateBeneficiary(
      {String? beneficiaryId,
      String? nickName,
      String? purpose,
      String? purposeDetails}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateBeneficiary(UpdateBeneficiaryRequest(
        beneficiaryId: beneficiaryId!,
        nickName: nickName,
        purpose: purpose,
        purposeDetails: purposeDetails,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> uploadBeneficiaryImage(
      {String? filePath, String? beneficiaryId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.uploadBeneficiaryImage(UploadBeneficiaryImageRequest(
        image: ImageUtils.convertToBase64(filePath!),
        beneficiaryID: beneficiaryId!,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> verifyBeneficiaryOtp(
      {String? type, String? otpCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyBeneficiaryOtp(VerifyBeneficiaryOtpRequest(
        type: type!, otp: otpCode!, baseData: baseData.toJson()));
  }
}
