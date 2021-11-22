import 'package:blinkid_flutter/recognizers/blink_id_combined_recognizer.dart';
import 'package:dartz/dartz.dart';
import 'package:data/entity/local/user_db_entity.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:retrofit/dio.dart';

abstract class UserRemoteDS {
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName(
      {String email});

  Future<String> loginUser({required String email, required String password});

  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserNameMobile(
      {String? mobileNumber, String? countryCode});

  Future<String> fetchCountryList({bool? getToken});

  Future<String> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? password,
      String? confirmPassword,
      String? userName});

  Future<String> saveIdInfo(
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
      double? scanPercentage});

  Future<String> saveJobInformation(
      {String? employeeName,
      String? occupation,
      String? annualIncome,
      String? employerCountry,
      String? employerCity,
      String? employerContact,
      bool? additionalIncome,
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
      String? natureOfSpecialNeeds});

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
          String? permanentStreetAddress});

  Future<bool> verifyMobileOtp({String? otpCode, bool? getToken});
}

abstract class UserLocalDS {
  Future<Stream<UserDBEntity?>> listenCurrentUser();

  Future<UserDBEntity?> getCurrentUser();

  Future<bool> removeUser();

  Future<bool> saveCurrentUser(UserDBEntity userDBEntity);

  Future<Either<LocalError, BlinkIdCombinedRecognizerResult>>
      scanUserDocument();
}
