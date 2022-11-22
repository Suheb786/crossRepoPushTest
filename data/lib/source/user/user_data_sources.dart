import 'package:blinkid_flutter/recognizers/blink_id_combined_recognizer.dart';
import 'package:dartz/dartz.dart';
import 'package:data/entity/remote/user/biometric_login/get_cipher_response_entity.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_response_entity.dart';
import 'package:data/entity/remote/user/current_version/current_version_response_entity.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_response_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_response_entity.dart';
import 'package:data/entity/remote/user/get_token_response_entity.dart';
import 'package:data/entity/remote/user/login_response_entity.dart';
import 'package:data/entity/remote/user/logout/logout_response_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_response_entity.dart';
import 'package:data/entity/remote/user/register_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_id_info_response_entity.dart';
import 'package:data/entity/remote/user/save_job_details_response_entity.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:data/entity/remote/user/status/customer_status_response_entity.dart';
import 'package:data/entity/remote/user/verify_otp_response_entity.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/model/user/user.dart';
import 'package:retrofit/dio.dart';

abstract class UserRemoteDS {
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName({String email});

  Future<HttpResponse<LoginResponseEntity>> loginUser({required String email, required String password});

  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserNameMobile(
      {String? mobileNumber, String? countryCode});

  Future<String> fetchCountryList({bool? getToken});

  Future<HttpResponse<RegisterResponseEntity>> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? mobileCode,
      String? password,
      String? confirmPassword,
      String? userName});

  Future<HttpResponse<SaveIdInfoResponseEntity>> saveIdInfo(
      {String? id,
      String? type,
      String? fullName,
      String? middleName,
      String? firstName,
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
      String? placeOfBirth,
      String? doi});

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
      List<AdditionalIncomeType>? additionalIncomeType});

  Future<HttpResponse<SaveProfileStatusResponseEntity>> saveProfileInformation(
      {bool? married,
      bool? specialPerson,
      bool? anyOtherNationality,
      bool? beneficialOwnerAccount,
      String? otherNationality,
      String? employmentStatus,
      String? spouseName,
      bool? isEmployed,
      String? natureOfSpecialNeeds});

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
  });

  Future<HttpResponse<VerifyOtpResponseEntity>> verifyMobileOtp({String? otpCode});

  Future<HttpResponse<ResponseEntity>> uploadSelfieImage({String? imagePath});

  Future<HttpResponse<GetTokenResponseEntity>> getToken();

  Future<HttpResponse<GetConfirmApplicationDataResponseEntity>> confirmApplicationDataGet();

  Future<HttpResponse<RegisterInterestResponseEntity>> registerInterest({String? email});

  Future<HttpResponse<LogoutResponseEntity>> logout();

  Future<HttpResponse<ConfirmApplicationDataSetResponseEntity>> confirmApplicationDataSet(
      {CountryResidenceInfo? countryResidenceInfo,
      ProfileStatusInfo? profileStatusInfo,
      JobDetailInfo? jobDetailInfo,
      FatcaCrsInfo? fatcaCrsInfo,
      AccountPurposeInfo? accountPurposeInfo});

  Future<bool> enableFingerPrint({String? cipher});

  Future<HttpResponse<ResponseEntity>> disableFingerPrint();

  Future<HttpResponse<GenerateKeyPairResponseEntity>> generateKeyPair();

  Future<HttpResponse<ResponseEntity>> enableBiometric();

  Future<HttpResponse<GetComboValuesResponseEntity>> getComboValues();

  Future<HttpResponse<CustomerStatusResponseEntity>> checkCustomerStatus();

  Future<HttpResponse<GetCipherResponseEntity>> getCipher();

  Future<HttpResponse<ResponseEntity>> androidLogin({required String cipher});

  Future<HttpResponse<LoginResponseEntity>> iphoneLogin({required String cipher});

  Future<HttpResponse<ResponseEntity>> changeMyNumber({String mobileNo, String mobileCode});

  Future<HttpResponse<CurrentVersionResponseEntity>> checkVersionUpdate({String? clear});
}

abstract class UserLocalDS {
  Future<User?> getCurrentUser();

  Future<bool> removeUser();

  Future<bool> saveCurrentUser(User user);

  Future<Either<LocalError, BlinkIdCombinedRecognizerResult>> scanUserDocument();

  Future<bool> checkBioMetricSupport();

  Future<bool> authenticateBioMetric(String title, String localisedReason);
}
