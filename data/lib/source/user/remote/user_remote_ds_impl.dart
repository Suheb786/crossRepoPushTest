import 'dart:io';

import 'package:data/entity/local/base/crypto_util.dart';
import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/base/base_response.dart';
import 'package:data/entity/remote/user/account_registration/check_journey_status/check_journey_status_request_entity.dart';
import 'package:data/entity/remote/user/account_registration/process_journey_via_mobile/process_journey_via_mobile_request_Entity.dart';
import 'package:data/entity/remote/user/account_registration/send_email_otp_request.dart';
import 'package:data/entity/remote/user/account_registration/update_journey_request_entity.dart';
import 'package:data/entity/remote/user/additional_income.dart';
import 'package:data/entity/remote/user/biometric_login/get_cipher_response_entity.dart';
import 'package:data/entity/remote/user/change_my_number/change_my_number_request_entity.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/check_version_update_request.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/account_purpose_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/confirm_application_data_get_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/country_residence_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/fatca_crs_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/job_detail_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/profile_status_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/review_application_data_entity.dart';
import 'package:data/entity/remote/user/current_version/current_version_response_entity.dart';
import 'package:data/entity/remote/user/disable_finger_print/disable_finger_print_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/android_login_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/android_login_response_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/enable_biometric_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/get_cipher_request_entity.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_request_entity.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_response_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_request_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_response_entity.dart';
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
import 'package:data/entity/remote/user/status/customer_status_response_entity.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
import 'package:data/entity/remote/user/verify_otp_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/user/check_journey_status_usecase.dart';
import 'package:domain/usecase/user/process_journey_via_mobile_usecase.dart';
import 'package:domain/usecase/user/update_journey_usecase.dart';
import 'package:retrofit/retrofit.dart';

import '../../../entity/remote/user/account_registration/check_journey_status/check_journey_status_response_entity.dart';
import '../../../entity/remote/user/account_registration/process_journey_via_mobile/process_journey_via_mobile_response_entity.dart';
import '../../../entity/remote/user/account_registration/update_journey/update_journey_response_entity.dart';
import '../../../entity/remote/user/account_registration/verify_email_otp_request.dart';

class UserRemoteDSImpl extends UserRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;
  final UserLocalDS _userLocalDS;

  UserRemoteDSImpl(this._apiService, this._deviceInfoHelper, this._userLocalDS);

  @override
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName({String? email}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    Map<String, dynamic> content = Map();
    content.putIfAbsent("userName", () => email);
    content.putIfAbsent("UniqueId", () => DateTime.now().microsecondsSinceEpoch.toString());
    return _apiService.checkUserName(CheckUserEmailRequest(baseData: baseData.toJson(), content: content));
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
    // BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    Map<String, dynamic> content = Map();
    content.putIfAbsent("MobileNumber", () => mobileNumber);
    content.putIfAbsent("CountryCode", () => countryCode);
    content.putIfAbsent("UniqueId", () => DateTime.now().microsecondsSinceEpoch.toString());
    return _apiService.checkUserNameMobile(CheckUserNameMobileRequest(content: content));
  }

  @override
  Future<HttpResponse<RegisterResponseEntity>> registerProspectUser({
    String? countryName,
    String? email,
    String? mobileNumber,
    String? mobileCode,
    String? password,
    String? confirmPassword,
    String? userName,
    String? referralCode,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.registerProspectUser(RegisterProspectUserRequest(
        baseData: baseData.toJson(),
        getToken: false,
        mobileNumber: mobileNumber,
        mobileCode: mobileCode,
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
        referralCode: referralCode,
        vkeySessionId: baseData.vKeySessionId));
  }

  @override
  Future<HttpResponse<SaveIdInfoResponseEntity>> saveIdInfo(
      {String? id,
      String? type,
      String? fullName,
      String? firstName,
      String? middleName,
      String? placeOfBirth,
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
      double? scanPercentage,
      String? doi}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveIdInfo(SaveIdInfoRequest(
        baseData: baseData.toJson(),
        getToken: true,
        type: "C",
        dob: dob,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        backCardImage: backCardImage,
        documentCode: documentCode ?? 'I',
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
        issuer: issuer,
        middleName: middleName,
        motherName: motherName,
        mrtDraw: mrtDraw,
        nationality: nationality,
        optionalData1: optionalData1,
        optionalData2: optionalData2,
        personFaceImage: personFaceImage,
        scanPercentage: 0,
        doi: doi,
        placeOfBirth: placeOfBirth));
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
      String? businessType,
      String? specifyBusinessType,
      String? mainSource,
      List<AdditionalIncomeType>? additionalIncomeType}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveJobInformation(SaveJobInfoRequest(
        baseData: baseData.toJson(),
        occupation: occupation ?? '',
        annualIncome: annualIncome ?? '',
        employeeName: employeeName ?? '',
        employerCountries: employerCountry ?? 'Jordan',
        employerCity: employerCity ?? '',
        employerContact: employerContact ?? '',
        mainSource: 'JOB',
        businessType: businessType ?? '',
        additionalIncomes: additionalIncome,
        additionalIncome: additionalIncomeType!.map((e) => AdditionalIncome().restore(e)).toList()));
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
      bool? isEmployed,
      String? natureOfSpecialNeeds}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveProfileInformation(SaveProfileInformationRequest(
        baseData: baseData.toJson(),
        married: married,
        specialPerson: specialPerson,
        employmentStatus: employmentStatus,
        spauseName: spouseName,
        natureSP: natureOfSpecialNeeds,
        additionalNationality: otherNationality,
        isEmployed: isEmployed,
        isAdditionalNational: anyOtherNationality,
        isBeneficialOwner: beneficialOwnerAccount));
  }

  @override
  Future<HttpResponse<SaveCountryResidenceInfoResponseEntity>> saveResidenceInformation({
    String? residentCountry,
    String? buildingName,
    String? streetName,
    String? residentArea,
    String? residentCity,
    String? permanentResidentCountry,
    String? permanentResidentCity,
    String? stateId,
    String? cityId,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveResidenceInformation(SaveResidenceInformationRequest(
        baseData: baseData.toJson(),
        residantCountry: residentCountry,
        buildingName: buildingName,
        streetName: streetName,
        area: residentArea,
        perCountry: permanentResidentCountry,
        perCity: permanentResidentCity,
        stateID: stateId,
        cityId: cityId));
  }

  @override
  Future<HttpResponse<VerifyOtpResponseEntity>> verifyMobileOtp({String? otpCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyMobileOtp(
        VerifyMobileOtpRequest(getToken: true, otpCode: otpCode, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetTokenResponseEntity>> getToken() {
    return _apiService.getToken();
  }

  @override
  Future<HttpResponse<GetConfirmApplicationDataResponseEntity>> confirmApplicationDataGet() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmApplicationDataGet(
        ConfirmApplicationDataGetRequestEntity(getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<RegisterInterestResponseEntity>> registerInterest({String? email}) async {
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
  Future<HttpResponse<ConfirmApplicationDataSetResponseEntity>> confirmApplicationDataSet(
      {CountryResidenceInfo? countryResidenceInfo,
      ProfileStatusInfo? profileStatusInfo,
      JobDetailInfo? jobDetailInfo,
      FatcaCrsInfo? fatcaCrsInfo,
      AccountPurposeInfo? accountPurposeInfo}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmApplicationDataSet(ConfirmApplicationDataSetRequestEntity(
        getToken: true,
        reviewDocumentResponse: ReviewApplicationDataEntity(
                profileStatus: ProfileStatusEntity().restore(profileStatusInfo!).toJson(),
                jobDetail: JobDetailEntity().restore(jobDetailInfo!).toJson(),
                fatcaCrs: FatcaCrsEntity().restore(fatcaCrsInfo!).toJson(),
                countryResidence: CountryResidenceEntity().restore(countryResidenceInfo!).toJson(),
                accountPurpose: AccountPurposeEntity().restore(accountPurposeInfo!).toJson())
            .toJson(),
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> disableFingerPrint() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.disableFingerPrint(DisableFingerPrintRequestEntity(
        getToken: true,
        uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> uploadSelfieImage({String? imagePath}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.uploadSelfieImage(SaveSelfieImageRequest(
        baseData: baseData.toJson(), getToken: true, selfieImage: ImageUtils.convertToBase64(imagePath!)));
  }

  @override
  Future<HttpResponse<GenerateKeyPairResponseEntity>> generateKeyPair() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.generateKeyPair(GenerateKeyPairRequestEntity(
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> enableBiometric() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    User? user = await _userLocalDS.getCurrentUser();
    return _apiService.enableBiometric(EnableBiometricRequestEntity(
      publicKey: user.publicPEM,
      cipher: await encryptData(content: user.id, publicKey: user.publicPEM, privateKey: user.privatePEM),
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<GetComboValuesResponseEntity>> getComboValues() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getComboValues(GetComboValuesRequestEntity(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<CustomerStatusResponseEntity>> checkCustomerStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkCustomerStatus(BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<GetCipherResponseEntity>> getCipher() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCipher(GetCipherRequestEntity(
      uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<AndroidLoginResponseEntity>> androidLogin({required String cipher}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    User? user = await _userLocalDS.getCurrentUser();
    String userId = '';
    userId = user.id ?? '';
    // print('user private key--->${user.privatePEM}');
    //userId = await decryptData(content: cipher, publicKey: user.publicPEM, privateKey: user.privatePEM);

    return _apiService.androidLogin(AndroidLoginRequestEntity(
      uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
      fireBaseToken: "",
      signature: await signedData(userId: userId, privateKey: user.privatePEM!),
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeMyNumber({String? mobileNo, String? mobileCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeMyNumber(ChangeMyNumberRequestEntity(
      getToken: true,
      mobileNo: mobileNo,
      mobileCode: mobileCode,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<CurrentVersionResponseEntity>> checkVersionUpdate({String? clear}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkVersionUpdate(CheckVersionUpdateRequest(
      uniqueId: DateTime.now().microsecondsSinceEpoch.toString(),
      platform: baseData.platform,
      parentVersion: Platform.isAndroid
          ? '2.0'
          : Platform.isIOS
              ? '2.0'
              : '',
      clear: clear,
      // version: '2.0.0',
      version: baseData.appVersion,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<BaseResponse>> sendEmailOTP({required String email, required String password}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.sendEmailOTP(SendEmailOTPRequest(
      getToken: true,
      email: email,
      password: password,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<BaseResponse>> verifyEmailOTP({required String email, required String otpCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.verifyEmailOTP(VerifyEmailOTPRequest(
      email: email,
      otpCode: otpCode,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<UpdateJourneyResponseEntity>> updateJourney(
      {required UpdateJourneyUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateJourney(UpdateJourneyRequestEntity(
      userID: params.userID,
      refID: params.refID,
      journeyID: params.journeyID,
      status: params.status,
      baseClass: baseData.toJson(),
      getToken: true,
    ));
  }

  @override
  Future<HttpResponse<CheckJourneyStatusResponseEntity>> updateIdWiseStatus(
      {required CheckJourneyStatusUseCaseUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkJourneyStatus(CheckJourneyStatusRequestEntity(
      referenceId: params.referenceId,
      journeyId: params.journeyId,
      baseData: baseData.toJson(),
      getToken: true,
    ));
  }

  @override
  Future<HttpResponse<ProcessJourneViaMobileResponseEntity>> processJourneyViaMobile(
      {required ProcessJourneyViaMobileUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.processJourneyViaMobile(
      ProcessJourneyViaMobileRequestEntity(
          JourneyId: params.journeyId,
          ReferenceID: params.referenceID,
          baseData: baseData.toJson(),
          getToken: true),
    );
  }
}
