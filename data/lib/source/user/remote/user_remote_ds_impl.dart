import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/user/additional_income.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/confirm_application_data_get_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_response_entity.dart';
import 'package:data/entity/remote/user/fetch_countrylist_request.dart';
import 'package:data/entity/remote/user/get_token_response_entity.dart';
import 'package:data/entity/remote/user/login_response_entity.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/entity/remote/user/logout/logout_request_entity.dart';
import 'package:data/entity/remote/user/logout/logout_response_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_request_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_response_entity.dart';
import 'package:data/entity/remote/user/register_prospect_user_request.dart';
import 'package:data/entity/remote/user/register_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_id_info_request.dart';
import 'package:data/entity/remote/user/save_id_info_response_entity.dart';
import 'package:data/entity/remote/user/save_job_details_response_entity.dart';
import 'package:data/entity/remote/user/save_job_info_request.dart';
import 'package:data/entity/remote/user/save_profile_information_request.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:data/entity/remote/user/save_residence_information_request.dart';
import 'package:data/entity/remote/user/save_selfie_image_request.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
import 'package:data/entity/remote/user/verify_otp_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:retrofit/retrofit.dart';

class UserRemoteDSImpl extends UserRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  UserRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName(
      {String? email}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    Map<String, dynamic> content = Map();
    content.putIfAbsent("userName", () => email);
    content.putIfAbsent(
        "UniqueId", () => DateTime.now().microsecondsSinceEpoch.toString());
    return _apiService.checkUserName(
        CheckUserEmailRequest(baseData: baseData.toJson(), content: content));
  }

  @override
  Future<HttpResponse<LoginResponseEntity>> loginUser(
      {required String email, required String password}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.loginUser(LoginUserRequest(
      uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
      platform: baseData.platform,
      password: password,
      userName: email,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserNameMobile(
      {String? mobileNumber, String? countryCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    Map<String, dynamic> content = Map();
    content.putIfAbsent("MobileNumber", () => mobileNumber);
    content.putIfAbsent("CountryCode", () => countryCode);
    content.putIfAbsent(
        "UniqueId", () => DateTime.now().microsecondsSinceEpoch.toString());
    return _apiService
        .checkUserNameMobile(CheckUserNameMobileRequest(content: content));
  }

  @override
  Future<String> fetchCountryList({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.fetchCountryList(
        FetchCountryListRequest(baseData: baseData, getToken: getToken));
  }

  @override
  Future<HttpResponse<RegisterResponseEntity>> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? password,
      String? confirmPassword,
      String? userName}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.registerProspectUser(RegisterProspectUserRequest(
        baseData: baseData.toJson(),
        getToken: false,
        mobileNumber: mobileNumber,
        email: email,
        companyId: 2,
        confirmPassword: confirmPassword,
        countryName: countryName,
        fireBaseToken: "",
        languageCode: "En",
        password: password,
        platform: baseData.platform,
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
        userName: userName,
        vkeySessionId: baseData.vKeySessionId));
  }

  @override
  Future<HttpResponse<SaveIdInfoResponseEntity>> saveIdInfo(
      {String? id,
      String? type,
      String? fullName,
      String? firstName,
      String? middleName,
      String? familyName,
      String? idNumber,
      String? dob,
      String? nationality,
      String? doe,
      String? gender,
      String? motherName,
      String? documentCode,
      String? documentNumber,
      String? issuer,
      String? optionalData1,
      String? optionalData2,
      String? mrtDraw,
      String? frontCardImage,
      String? backCardImage,
      String? personFaceImage,
      bool? getToken,
      bool? isimtfBlacklist,
      String? instanceID,
      double? scanPercentage}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    ///TODO:change to dynamic data
    return _apiService.saveIdInfo(SaveIdInfoRequest(
        baseData: baseData.toJson(),
        getToken: true,
        type: "C",
        dob: dob,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        backCardImage: backCardImage,
        documentCode: 'I',
        documentNumber: documentNumber,
        doe: doe,
        familyName: familyName,
        firstName: firstName ?? fullName!.split(' ').first,
        frontCardImage: frontCardImage,
        fullName: fullName,
        gender: gender![0].toUpperCase(),
        idNumber: idNumber,
        instanceID: instanceID,
        isimtfBlacklist: false,
        issuer: nationality,
        middleName: middleName,
        motherName: motherName,
        mrtDraw: mrtDraw,
        nationality: nationality,
        optionalData1: optionalData1,
        optionalData2: optionalData2,
        personFaceImage: personFaceImage,
        scanPercentage: 0));
  }

  @override
  Future<HttpResponse<SaveJobDetailsResponseEntity>> saveJobInformation(
      {String? employeeName,
      String? occupation,
      String? annualIncome,
      String? employerCountry,
      String? employerCity,
      String? employerContact,
      bool? additionalIncome,
      String? mainSource,
      List<AdditionalIncomeType>? additionalIncomeType}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveJobInformation(SaveJobInfoRequest(
        baseData: baseData.toJson(),
        occupation: occupation,
        annualIncome: annualIncome,
        employeeName: employeeName,
        employerCountries: employerCountry,
        employerCity: employerCity,
        employerContact: employerContact,
        mainSource: 'JOB',
        additionalIncomes: additionalIncome,
        additionalIncome: additionalIncomeType!
            .map((e) => AdditionalIncome().restore(e))
            .toList()));
  }

  @override
  Future<HttpResponse<SaveProfileStatusResponseEntity>> saveProfileInformation(
      {bool? married,
      bool? specialPerson,
      bool? anyOtherNationality,
      bool? beneficialOwnerAccount,
      String? otherNationality,
      String? employmentStatus,
      String? spouseName,
      String? natureOfSpecialNeeds}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveProfileInformation(SaveProfileInformationRequest(
      baseData: baseData.toJson(),
      married: married,
      specialPerson: specialPerson,
      employmentStatus: employmentStatus,
      spauseName: spouseName,
      natureSP: natureOfSpecialNeeds,
    ));
  }

  @override
  Future<HttpResponse<SaveCountryResidenceInfoResponseEntity>>
      saveResidenceInformation(
          {String? residentCountry,
          String? buildingName,
          String? streetName,
          String? residentDistrict,
          String? residentCity,
          String? permanentResidentCountry,
          String? permanentResidentCity}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveResidenceInformation(SaveResidenceInformationRequest(
        baseData: baseData.toJson(),
        residantCountry: residentCountry,
        buildingName: buildingName,
        streetName: streetName,
        district: residentDistrict,
        city: residentCity,
        perCountry: permanentResidentCountry,
        perCity: permanentResidentCity));
  }

  @override
  Future<HttpResponse<VerifyOtpResponseEntity>> verifyMobileOtp(
      {String? otpCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyMobileOtp(VerifyMobileOtpRequest(
        getToken: true, otpCode: otpCode, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetTokenResponseEntity>> getToken() {
    return _apiService.getToken();
  }

  @override
  Future<HttpResponse<GetConfirmApplicationDataResponseEntity>>
      confirmApplicationDataGet() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmApplicationDataGet(
        ConfirmApplicationDataGetRequestEntity(
            getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<RegisterInterestResponseEntity>> registerInterest(
      {String? email}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.registerInterest(RegisterInterestRequestEntity(
        email: email,
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<LogoutResponseEntity>> logout() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.logout(LogoutRequestEntity(
        platform: baseData.platform,
        vkeySessionId: baseData.vKeySessionId,
        appVersion: baseData.appVersion,
        browser: baseData.browser,
        channelType: baseData.channelType,
        deviceID: baseData.deviceID,
        iP: baseData.ip,
        latitude: baseData.latitude,
        longitude: baseData.longitude,
        mobileModel: baseData.mobileModel));
  }

  @override
  Future<HttpResponse<ResponseEntity>> uploadSelfieImage(
      {String? imagePath}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.uploadSelfieImage(SaveSelfieImageRequest(
        baseData: baseData.toJson(),
        getToken: true,
        selfieImage: ImageUtils.convertToBase64(imagePath!)));
  }
}
