import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/contact/add_beneficiary_request.dart';
import 'package:data/entity/remote/contact/contact_detail_request.dart';
import 'package:data/entity/remote/contact/delete_beneficiary_request.dart';
import 'package:data/entity/remote/contact/get_beneficiary_response_entity.dart';
import 'package:data/entity/remote/contact/list_of_contacts_request.dart';
import 'package:data/entity/remote/contact/search_contact_request.dart';
import 'package:data/entity/remote/contact/update_beneficiary_request.dart';
import 'package:data/entity/remote/contact/update_favorite_request.dart';
import 'package:data/entity/remote/contact/upload_beneficiary_image_request.dart';
import 'package:data/entity/remote/contact/verify_beneficiary_otp_request.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/contact/contact_data_source.dart';
import 'package:retrofit/dio.dart';

import '../../../entity/remote/contact/add_contact_request.dart';
import '../../../entity/remote/contact/update_contact_request.dart';

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
  Future<HttpResponse<ResponseEntity>> deleteBeneficiary({String? beneficiaryId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteBeneficiary(
        DeleteBeneficiaryRequest(beneficiaryId: beneficiaryId!, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetBeneficiaryResponseEntity>> getBeneficiaries() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getBeneficiaries(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateBeneficiary(
      {String? beneficiaryId, String? nickName, String? purpose, String? purposeDetails}) async {
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
  Future<HttpResponse<ResponseEntity>> verifyBeneficiaryOtp({String? type, String? otpCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyBeneficiaryOtp(
        VerifyBeneficiaryOtpRequest(type: type!, otp: otpCode!, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> contactDetail(
      {required String beneficiaryDetailId, required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.contactDetail(ContactDetailRequest(
        baseData: baseData.toJson(), beneficiaryDetailId: beneficiaryDetailId, isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> listOfContacts({required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .listOfContacts(ListOfContactRequest(baseData: baseData.toJson(), isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> searchContact(
      {required String searchText, required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.searchContact(SearchContactRequest(
        baseData: baseData.toJson(), searchText: searchText, isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateFavorite(
      {required String beneficiaryDetailId,
      required bool isFav,
      required String userId,
      required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateFavorite(UpdateFavoriteRequest(
        baseData: baseData.toJson(),
        beneficiaryDetailId: beneficiaryDetailId,
        isFav: isFav,
        isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> addContact(
      {String? nickName,
        String? fullName,
        String? emailAddress,
        String? avatarImage,
        bool? isFav,
        String? userId,
        String? identifier,
        String? isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addContact(AddContactRequest(
        nickName: nickName,
        fullName: fullName,
        emailAddress: emailAddress,
        avatarImg: ImageUtils.convertToBase64(avatarImage!),
        isFav: isFav,
        userId: userId,
        identifier: identifier,
        isFromMobile: isFromMobile,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateContact(
      {String? beneficiaryDetailId,
        String? nickName,
        String? fullName,
        String? emailAddress,
        String? userId,
        String? identifier,
        String? isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateContact(UpdateContactRequest(
        beneficiaryDetailId: beneficiaryDetailId,
        nickName: nickName,
        fullName: fullName,
        emailAddress: emailAddress,
        userId: userId,
        identifier: identifier,
        isFromMobile: isFromMobile,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> deleteContact(
      {String? beneficiaryDetailId,
        String? nickName,
        String? fullName,
        String? emailAddress,
        String? avatarImage,
        bool? isFav,
        String? userId,
        String? identifier,
        String? isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addContact(AddContactRequest(
        nickName: nickName,
        fullName: fullName,
        emailAddress: emailAddress,
        avatarImg: ImageUtils.convertToBase64(avatarImage!),
        isFav: isFav,
        userId: userId,
        identifier: identifier,
        isFromMobile: isFromMobile,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateAvatar(
      {String? beneficiaryDetailId, String? avatarImage, String? userId, String? isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addContact(AddContactRequest(
        avatarImg: ImageUtils.convertToBase64(avatarImage!),
        userId: userId,
        isFromMobile: isFromMobile,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> contactDetail(
      {required String beneficiaryDetailId, required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.contactDetail(ContactDetailRequest(
        baseData: baseData.toJson(), beneficiaryDetailId: beneficiaryDetailId, isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> listOfContacts({required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .listOfContacts(ListOfContactRequest(baseData: baseData.toJson(), isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> searchContact(
      {required String searchText, required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.searchContact(SearchContactRequest(
        baseData: baseData.toJson(), searchText: searchText, isFromMobile: isFromMobile));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateFavorite(
      {required String beneficiaryDetailId,
      required bool isFav,
      required String userId,
      required bool isFromMobile}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateFavorite(UpdateFavoriteRequest(
        baseData: baseData.toJson(),
        beneficiaryDetailId: beneficiaryDetailId,
        isFav: isFav,
        isFromMobile: isFromMobile));
  }
}
