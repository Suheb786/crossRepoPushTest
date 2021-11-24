import 'package:dartz/dartz.dart';
import 'package:data/db/floor/utils/safe_db_call.dart';
import 'package:data/entity/local/user_db_entity.dart';
import 'package:data/network/api_interceptor.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';

/// user repository management class
class UserRepositoryImpl extends UserRepository {
  final UserRemoteDS _remoteDS;
  final UserLocalDS _localDS;
  final Dio _dio;

  UserRepositoryImpl(
    this._remoteDS,
    this._localDS,
    this._dio,
  ) {
    _dio.interceptors.add(ApiInterceptor(this, _dio));
  }

  @override
  Future<Either<DatabaseError, Stream<User>>> listenCurrentUser() async {
    final result = await safeDbCall(
      _localDS.listenCurrentUser(),
    );
    return result.fold(
      (l) {
        print("left error is ${l.cause}");
        return Left(l);
      },
      (r) {
        return Right(
          r.map(
            (currentUser) => currentUser!.transform(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<DatabaseError, User>> getCurrentUser() async {
    final result = await safeDbCall(
      _localDS.getCurrentUser(),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(r!.transform()),
    );
  }

  @override
  Future<Either<DatabaseError, bool>> logoutUser() async {
    final logoutUser = await safeDbCall(_localDS.removeUser());
    return logoutUser.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<DatabaseError, User>> saveUser(User tokenUser) async {
    final result = await safeDbCall(
      _localDS.saveCurrentUser(UserDBEntity().restore(tokenUser)),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(tokenUser),
    );
  }

  @override
  Future<Either<NetworkError, CheckUsername>> checkUserName(
      {String? email}) async {
    final result = await safeApiCall(
      _remoteDS.checkUserName(email: email!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, User>> loginUser(
      {required String email, required String password}) async {
    final result = await safeApiCall(
      _remoteDS.loginUser(email: email, password: password),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckUsername>> checkUserNameMobile(
      {String? mobileNumber, String? countryCode}) async {
    final result = await safeApiCall(
      _remoteDS.checkUserNameMobile(
          mobileNumber: mobileNumber, countryCode: countryCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, String>> fetchCountryList(
      {bool? getToken}) async {
    final result = await safeApiCall(
      _remoteDS.fetchCountryList(getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<NetworkError, User>> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? password,
      String? confirmPassword,
      String? userName}) async {
    final result = await safeApiCall(
      _remoteDS.registerProspectUser(
          countryName: countryName,
          email: email,
          mobileNumber: mobileNumber,
          password: password,
          confirmPassword: confirmPassword,
          userName: userName),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, String>> saveIdInfo(
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
    final result = await safeApiCall(
      _remoteDS.saveIdInfo(
          id: id,
          type: type,
          fullName: fullName,
          middleName: middleName,
          familyName: familyName,
          idNumber: idNumber,
          dob: dob,
          nationality: nationality,
          doe: doe,
          gender: gender,
          motherName: motherName,
          documentCode: documentCode,
          documentNumber: documentNumber,
          issuer: issuer,
          optionalData1: optionalData1,
          optionalData2: optionalData2,
          mrtDraw: mrtDraw,
          frontCardImage: frontCardImage,
          backCardImage: backCardImage,
          personFaceImage: personFaceImage,
          getToken: getToken,
          isimtfBlacklist: isimtfBlacklist,
          instanceID: instanceID,
          scanPercentage: scanPercentage),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<NetworkError, String>> saveJobInformation(
      {String? employeeName,
      String? occupation,
      String? annualIncome,
      String? employerCountry,
      String? employerCity,
      String? employerContact,
      bool? additionalIncome,
      String? mainSource,
      List<AdditionalIncomeType>? additionalIncomeType}) async {
    final result = await safeApiCall(
      _remoteDS.saveJobInformation(
          employeeName: employeeName,
          occupation: occupation,
          annualIncome: annualIncome,
          employerCountry: employerCountry,
          employerCity: employerCity,
          employerContact: employerContact,
          additionalIncome: additionalIncome,
          mainSource: mainSource,
          additionalIncomeType: additionalIncomeType),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<NetworkError, SaveProfileStatusResponse>>
      saveProfileInformation(
          {bool? married,
          bool? specialPerson,
          bool? anyOtherNationality,
          bool? beneficialOwnerAccount,
          String? otherNationality,
          String? employmentStatus,
          String? spouseName,
          String? natureOfSpecialNeeds}) async {
    final result = await safeApiCall(_remoteDS.saveProfileInformation(
        married: married,
        specialPerson: specialPerson,
        anyOtherNationality: anyOtherNationality,
        beneficialOwnerAccount: beneficialOwnerAccount,
        otherNationality: otherNationality,
        employmentStatus: employmentStatus,
        spouseName: spouseName,
        natureOfSpecialNeeds: natureOfSpecialNeeds));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
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
          String? permanentStreetAddress}) async {
    final result = await safeApiCall(_remoteDS.saveResidenceInformation(
        residentCountry: residentCountry,
        homeAddress: homeAddress,
        streetAddress: streetAddress,
        residentDistrict: residentDistrict,
        residentCity: residentCity,
        permanentResidentCountry: permanentResidentCountry,
        permanentResidentCity: permanentResidentCity,
        permanentHomeAddress: permanentHomeAddress,
        permanentStreetAddress: permanentStreetAddress));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> verifyMobileOtp(
      {String? otpCode}) async {
    final result = await safeApiCall(
      _remoteDS.verifyMobileOtp(otpCode: otpCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<LocalError, ScannedDocumentInformation>>
      scanUserDocument() async {
    final document = await _localDS.scanUserDocument();
    return document.fold(
        (l) => Left(l),
        (r) => Right(ScannedDocumentInformation(
              fullName: r.fullName,
              firstName: r.firstName,
              middleName: r.fathersName,
              familyName: r.lastName,
              idNumber: r.documentNumber!.isNotEmpty ? r.documentNumber : '',
              dob: r.dateOfBirth != null
                  ? DateTime(r.dateOfBirth!.year!, r.dateOfBirth!.month!,
                      r.dateOfBirth!.day!)
                  : DateTime(0),
              nationality: r.nationality!.isNotEmpty ? r.nationality : '',
              doe: r.dateOfExpiry != null
                  ? DateTime(r.dateOfExpiry!.year!, r.dateOfExpiry!.month!,
                      r.dateOfExpiry!.day!)
                  : DateTime(0),
              gender: r.sex!.isNotEmpty ? r.sex : '',
              motherName: r.mothersName!.isNotEmpty ? r.mothersName : '',
              documentCode: r.documentAdditionalNumber!.isNotEmpty
                  ? r.documentAdditionalNumber
                  : '',
              documentNumber: r.documentNumber,
              issuer: r.issuingAuthority,
              frontCardImage: r.fullDocumentFrontImage,
              backCardImage: r.fullDocumentBackImage,
              personFaceImage: r.faceImage,
              issuingPlace: r.address,
              issuingDate: r.dateOfIssue != null
                  ? DateTime(r.dateOfIssue!.year!, r.dateOfIssue!.month!,
                      r.dateOfIssue!.day!)
                  : DateTime(0),
            )));
  }
}
