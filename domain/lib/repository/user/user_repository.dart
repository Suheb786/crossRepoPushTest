import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_response.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/model/user/register_interest/register_interest_response.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/model/user/user.dart';

abstract class UserRepository {
  /// Get current user
  Future<Either<DatabaseError, User>> getCurrentUser();

  /// Save logged in user
  Future<Either<DatabaseError, User>> saveUser(User tokenUser);

  /// Logout current user
  Future<Either<DatabaseError, bool>> logoutUser();

  /// Check email is available or not
  Future<Either<NetworkError, CheckUsername>> checkUserName({String? email});

  /// Login user with syste
  Future<Either<NetworkError, User>> loginUser({required String email, required String password});

  /// Check for userName mobile availability
  Future<Either<NetworkError, CheckUsername>> checkUserNameMobile(
      {String? mobileNumber, String? countryCode});

  /// register prospect user
  Future<Either<NetworkError, User>> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? mobileCode,
      String? password,
      String? confirmPassword,
      String? userName});

  /// verify mobile otp
  Future<Either<NetworkError, bool>> verifyMobileOtp({String? otpCode});

  /// Upload selfie image
  Future<Either<NetworkError, bool>> uploadSelfieImage({String? imagePath});

  /// save Id information
  Future<Either<NetworkError, SaveIdInfoResponse>> saveIdInfo(
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
      double? scanPercentage,
      String? placeOfBirth,
      String? doi});

  /// fetch country list
  Future<Either<NetworkError, String>> fetchCountryList({bool? getToken});

  /// save residence information
  Future<Either<NetworkError, SaveCountryResidenceInfoResponse>> saveResidenceInformation({
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

  /// save profile information
  Future<Either<NetworkError, SaveProfileStatusResponse>> saveProfileInformation(
      {bool? married,
      bool? specialPerson,
      bool? anyOtherNationality,
      bool? beneficialOwnerAccount,
      String? otherNationality,
      String? employmentStatus,
      String? spouseName,
      bool? isEmployed,
      String? natureOfSpecialNeeds});

  /// save job information
  Future<Either<NetworkError, SaveJobDetailsResponse>> saveJobInformation(
      {String? employeeName,
      String? occupation,
      String? businessType,
      String? specifyBusinessType,
      String? annualIncome,
      String? employerCountry,
      String? employerCity,
      String? employerContact,
      bool? additionalIncome,
      String? mainSource,
      List<AdditionalIncomeType>? additionalIncomeType});

  /// Scan User Document
  Future<Either<LocalError, ScannedDocumentInformation>> scanUserDocument();

  ///get token
  Future<Either<NetworkError, bool>> getToken();

  /// confirm application data get
  Future<Either<NetworkError, GetConfirmApplicationDataResponse>> confirmApplicationDataGet();

  ///register interest
  Future<Either<NetworkError, RegisterInterestResponse>> registerInterest({String? email});

  ///logout
  Future<Either<NetworkError, LogoutResponse>> logout();

  /// confirm application data set
  Future<Either<NetworkError, bool>> confirmApplicationDataSet(
      {CountryResidenceInfo countryResidenceInfo,
      ProfileStatusInfo profileStatusInfo,
      JobDetailInfo jobDetailInfo,
      FatcaCrsInfo fatcaCrsInfo,
      AccountPurposeInfo accountPurposeInfo});

  ///enable finger print
  Future<Either<NetworkError, bool>> enableFingerPrint({String cipher});

  ///disable finger print
  Future<Either<NetworkError, bool>> disableFingerPrint();

  ///generate key pair
  Future<Either<NetworkError, GenerateKeyPairResponse>> generateKeyPair();

  Future<Either<BaseError, bool>> checkBioMetricSupport();

  Future<Either<BaseError, bool>> authenticateBioMetric(String title, String localisedReason);

  ///enable biometric
  Future<Either<NetworkError, bool>> enableBiometric();

  ///get combo values
  Future<Either<NetworkError, GetComboValuesResponse>> getComboValues();

  Future<Either<NetworkError, CustomerStatus>> checkCustomerStatus();

  Future<Either<NetworkError, GetCipherResponse>> getCipher();

  Future<Either<NetworkError, AndroidLoginResponse>> androidLogin({required String cipher});

  Future<Either<NetworkError, User>> iphoneLogin({required String cipher});

  Future<Either<NetworkError, bool>> changeMyNumber(String mobileNo, String mobileCode);

  Future<Either<NetworkError, bool>> checkVersionUpdate({String? clear});

  /// clear wallet id
  Future<Either<DatabaseError, bool>> clearWalletId();
}
