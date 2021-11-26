import 'package:dartz/dartz.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_response.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/model/user/user.dart';

abstract class UserRepository {
  /// Listen current user stream
  Future<Either<DatabaseError, Stream<User>>> listenCurrentUser();

  /// Get current user
  Future<Either<DatabaseError, User>> getCurrentUser();

  /// Save logged in user
  Future<Either<DatabaseError, User>> saveUser(User tokenUser);

  /// Logout current user
  Future<Either<DatabaseError, bool>> logoutUser();

  /// Check email is available or not
  Future<Either<NetworkError, CheckUsername>> checkUserName({String? email});

  /// Login user with syste
  Future<Either<NetworkError, User>> loginUser(
      {required String email, required String password});

  /// Check for userName mobile availability
  Future<Either<NetworkError, CheckUsername>> checkUserNameMobile(
      {String? mobileNumber, String? countryCode});

  /// register prospect user
  Future<Either<NetworkError, User>> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? password,
      String? confirmPassword,
      String? userName});

  /// verify mobile otp
  Future<Either<NetworkError, bool>> verifyMobileOtp({String? otpCode});

  /// save Id information
  Future<Either<NetworkError, SaveIdInfoResponse>> saveIdInfo({
    String? id,
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
  });

  /// fetch country list
  Future<Either<NetworkError, String>> fetchCountryList({bool? getToken});

  /// save residence information
  Future<Either<NetworkError, SaveCountryResidenceInfoResponse>>
      saveResidenceInformation(
          {String? residentCountry,
          String? homeAddress,
          String? streetAddress,
          String? residentDistrict,
          String? residentCity,
          String? permanentResidentCountry,
          String? permanentResidentCity,
          String? permanentHomeAddress,
          String? permanentStreetAddress});

  /// save profile information
  Future<Either<NetworkError, SaveProfileStatusResponse>>
      saveProfileInformation(
          {bool? married,
          bool? specialPerson,
          bool? anyOtherNationality,
          bool? beneficialOwnerAccount,
          String? otherNationality,
          String? employmentStatus,
          String? spouseName,
          String? natureOfSpecialNeeds});

  /// save job information
  Future<Either<NetworkError, SaveJobDetailsResponse>> saveJobInformation(
      {String? employeeName,
      String? occupation,
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
  Future<Either<NetworkError, GetConfirmApplicationDataResponse>>
      confirmApplicationDataGet();
}
