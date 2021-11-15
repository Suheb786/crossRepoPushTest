import 'package:data/entity/local/user_db_entity.dart';
import 'package:domain/model/user/additional_income_type.dart';

abstract class UserRemoteDS {
  Future<String> checkUserName({String email});

  Future<String> loginUser({required String email, required String password});

  Future<String> checkUserNameMobile(
      {String? mobileNumber, String? countryCode});

  Future<String> fetchCountryList({bool? getToken});

  Future<String> registerProspectUser(
      {String? countryName,
      String? languageCode,
      String? uniqueId,
      int? companyId,
      String? email,
      String? mobileNumber,
      String? password,
      String? confirmPassword,
      String? userName,
      String? fireBaseToken,
      String? vKeySessionId,
      String? platform,
      bool? getToken});

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

  Future<String> saveProfileInformation(
      {bool? married,
      bool? specialPerson,
      bool? anyOtherNationality,
      bool? beneficialOwnerAccount,
      String? otherNationality,
      String? employmentStatus,
      String? spouseName,
      String? natureOfSpecialNeeds});

  Future<String> saveResidenceInformation(
      {String? residentCountry,
      String? homeAddress,
      String? streetAddress,
      String? residentDistrict,
      String? residentCity,
      String? permanentResidentCountry,
      String? permanentResidentCity,
      String? permanentHomeAddress,
      String? permanentStreetAddress});

  Future<String> verifyMobileOtp({String? otpCode, bool? getToken});
}

abstract class UserLocalDS {
  Future<Stream<UserDBEntity?>> listenCurrentUser();

  Future<UserDBEntity?> getCurrentUser();

  Future<bool> removeUser();

  Future<bool> saveCurrentUser(UserDBEntity userDBEntity);
}
