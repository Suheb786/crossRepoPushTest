import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/user/additional_income.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/fetch_countrylist_request.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/entity/remote/user/register_prospect_user_request.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_id_info_request.dart';
import 'package:data/entity/remote/user/save_job_info_request.dart';
import 'package:data/entity/remote/user/save_profile_information_request.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:data/entity/remote/user/save_residence_information_request.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
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
  Future<String> loginUser(
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
  Future<String> registerProspectUser(
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
  Future<String> saveIdInfo(
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
    return _apiService.saveIdInfo(SaveIdInfoRequest(
        baseData: baseData,
        getToken: getToken,
        type: type,
        dob: dob,
        id: id,
        backCardImage: backCardImage,
        documentCode: documentCode,
        documentNumber: documentNumber,
        doe: doe,
        familyName: familyName,
        firstName: firstName,
        frontCardImage: frontCardImage,
        fullName: fullName,
        gender: gender,
        idNumber: idNumber,
        instanceID: instanceID,
        isimtfBlacklist: isimtfBlacklist,
        issuer: issuer,
        middleName: middleName,
        motherName: motherName,
        mrtDraw: mrtDraw,
        nationality: nationality,
        optionalData1: optionalData1,
        optionalData2: optionalData2,
        personFaceImage: personFaceImage,
        scanPercentage: scanPercentage));
  }

  @override
  Future<String> saveJobInformation(
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
        baseData: baseData,
        occupation: occupation,
        annualIncome: annualIncome,
        employerCountries: employerCountry,
        employerCity: employerCity,
        employerContact: employerContact,
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
          String? homeAddress,
          String? streetAddress,
          String? residentDistrict,
          String? residentCity,
          String? permanentResidentCountry,
          String? permanentResidentCity,
          String? permanentHomeAddress,
          String? permanentStreetAddress}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveResidenceInformation(SaveResidenceInformationRequest(
        baseData: baseData.toJson(),
        residantCountry: residentCountry,
        homeAddress: homeAddress,
        streetAddress: streetAddress,
        permanentResidantCountry: permanentResidentCountry,
        permanentHomeAddre: permanentHomeAddress,
        permanentStreetAddress: permanentStreetAddress));
  }

  @override
  Future<bool> verifyMobileOtp({String? otpCode, bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyMobileOtp(VerifyMobileOtpRequest(
        baseData: baseData, otpCode: otpCode, getToken: getToken));
  }
}
