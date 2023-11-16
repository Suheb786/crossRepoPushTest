
import 'package:dartz/dartz.dart';
import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/db/safe_db_call.dart';
import 'package:data/entity/local/base/crypto_util.dart';
import 'package:data/helper/key_helper.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/current_version/current_version_response.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/model/user/check_journey_status/check_journey_status.dart';
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
import 'package:domain/model/user/process_journey_via_mobile/process_journey.dart';
import 'package:domain/model/user/register_interest/register_interest_response.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/model/user/update_journey/update_journey.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/user/check_journey_status_usecase.dart';
import 'package:domain/usecase/user/process_journey_via_mobile_usecase.dart';
import 'package:domain/usecase/user/update_journey_usecase.dart';

/// user repository management class
class UserRepositoryImpl extends UserRepository {
  final UserRemoteDS _remoteDS;
  final UserLocalDS _localDS;

  UserRepositoryImpl(
    this._remoteDS,
    this._localDS,
  );

  @override
  Future<Either<DatabaseError, User>> getCurrentUser() async {
    final result = await safeDbCall(
      _localDS.getCurrentUser(),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
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
      _localDS.saveCurrentUser(tokenUser),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(tokenUser),
    );
  }

  @override
  Future<Either<NetworkError, CheckUsername>> checkUserName({String? email}) async {
    final result = await safeApiCall(
      _remoteDS.checkUserName(email: email!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, User>> loginUser({required String email, required String password}) async {
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
      _remoteDS.checkUserNameMobile(mobileNumber: mobileNumber, countryCode: countryCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, User>> registerProspectUser(
      {String? countryName,
      String? email,
      String? mobileNumber,
      String? mobileCode,
      String? password,
      String? confirmPassword,
      String? userName,
      String? referralCode}) async {
    final result = await safeApiCall(
      _remoteDS.registerProspectUser(
          countryName: countryName,
          email: email,
          mobileNumber: mobileNumber,
          mobileCode: mobileCode,
          password: password,
          confirmPassword: confirmPassword,
          userName: userName,
          referralCode: referralCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
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
      String? placeOfBirth,
      bool? isimtfBlacklist,
      String? instanceID,
      double? scanPercentage,
      String? doi}) async {
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
          scanPercentage: scanPercentage,
          firstName: firstName,
          placeOfBirth: placeOfBirth,
          doi: doi),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, SaveJobDetailsResponse>> saveJobInformation(
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
          businessType: businessType,
          specifyBusinessType: specifyBusinessType,
          additionalIncomeType: additionalIncomeType),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, SaveProfileStatusResponse>> saveProfileInformation(
      {bool? married,
      bool? specialPerson,
      bool? anyOtherNationality,
      bool? beneficialOwnerAccount,
      String? otherNationality,
      String? employmentStatus,
      String? spouseName,
      bool? isEmployed,
      String? natureOfSpecialNeeds}) async {
    final result = await safeApiCall(_remoteDS.saveProfileInformation(
        married: married,
        specialPerson: specialPerson,
        anyOtherNationality: anyOtherNationality,
        beneficialOwnerAccount: beneficialOwnerAccount,
        otherNationality: otherNationality,
        employmentStatus: employmentStatus,
        spouseName: spouseName,
        isEmployed: isEmployed,
        natureOfSpecialNeeds: natureOfSpecialNeeds));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
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
  }) async {
    final result = await safeApiCall(_remoteDS.saveResidenceInformation(
        residentCountry: residentCountry,
        buildingName: buildingName,
        streetName: streetName,
        residentArea: residentArea,
        residentCity: residentCity,
        permanentResidentCountry: permanentResidentCountry,
        permanentResidentCity: permanentResidentCity,
        cityId: cityId,
        stateId: stateId));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> verifyMobileOtp({String? otpCode}) async {
    final result = await safeApiCall(
      _remoteDS.verifyMobileOtp(otpCode: otpCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getToken() async {
    final result = await safeApiCall(
      _remoteDS.getToken(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> uploadSelfieImage({String? imagePath}) async {
    final result = await safeApiCall(
      _remoteDS.uploadSelfieImage(imagePath: imagePath),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, GetConfirmApplicationDataResponse>> confirmApplicationDataGet() async {
    final result = await safeApiCall(
      _remoteDS.confirmApplicationDataGet(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, RegisterInterestResponse>> registerInterest({String? email}) async {
    final result = await safeApiCall(
      _remoteDS.registerInterest(email: email),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, LogoutResponse>> logout() async {
    final result = await safeApiCall(
      _remoteDS.logout(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> confirmApplicationDataSet(
      {CountryResidenceInfo? countryResidenceInfo,
      ProfileStatusInfo? profileStatusInfo,
      JobDetailInfo? jobDetailInfo,
      FatcaCrsInfo? fatcaCrsInfo,
      AccountPurposeInfo? accountPurposeInfo}) async {
    final result = await safeApiCall(
      _remoteDS.confirmApplicationDataSet(
          countryResidenceInfo: countryResidenceInfo,
          profileStatusInfo: profileStatusInfo,
          jobDetailInfo: jobDetailInfo,
          fatcaCrsInfo: fatcaCrsInfo,
          accountPurposeInfo: accountPurposeInfo),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> disableFingerPrint() async {
    final result = await safeApiCall(
      _remoteDS.disableFingerPrint(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<BaseError, bool>> checkBioMetricSupport() async {
    try {
      bool checkBioMetric = await _localDS.checkBioMetricSupport();
      return Right(checkBioMetric);
    } catch (exception) {
      return _handleAppLocalException(exception);
    }
  }

  @override
  Future<Either<LocalError, bool>> authenticateBioMetric(String title, String localisedReason) async {
    try {
      bool isAuthenticated = await _localDS.authenticateBioMetric(title, localisedReason);
      return Right(isAuthenticated);
    } catch (exception) {
      return _handleAppLocalException(exception);
    }
  }

  Left<LocalError, bool> _handleAppLocalException(exception) {
    switch (exception.runtimeType) {
      case AppLocalException:
        if (exception is AppLocalException) {
          return Left(
            LocalError(
              cause: Exception(
                exception.toString(),
              ),
              localError: exception.appLocalExceptionType.value,
              message: exception.toString(),
            ),
          );
        } else {
          return Left(
            LocalError(
              cause: Exception(
                exception.toString(),
              ),
              localError: 1,
              message: exception.toString(),
            ),
          );
        }
      default:
        return Left(
          LocalError(
            cause: Exception(
              exception.toString(),
            ),
            localError: 1,
            message: exception.toString(),
          ),
        );
    }
  }

  @override
  Future<Either<NetworkError, GenerateKeyPairResponse>> generateKeyPair() async {
    final result = await safeApiCall(
      _remoteDS.generateKeyPair(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> enableBiometric() async {
    final result = await safeApiCall(
      _remoteDS.enableBiometric(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, GetComboValuesResponse>> getComboValues() async {
    final result = await safeApiCall(
      _remoteDS.getComboValues(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CustomerStatus>> checkCustomerStatus() async {
    final result = await safeApiCall(
      _remoteDS.checkCustomerStatus(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetCipherResponse>> getCipher() async {
    final result = await safeApiCall(
      _remoteDS.getCipher(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, AndroidLoginResponse>> androidLogin({required String cipher}) async {
    final result = await safeApiCall(
      _remoteDS.androidLogin(cipher: cipher),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> changeMyNumber(String mobileNo, String mobileCode) async {
    final result = await safeApiCall(
      _remoteDS.changeMyNumber(mobileNo: mobileNo, mobileCode: mobileCode),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> checkVersionUpdate({String? clear}) async {
    final result = await safeApiCall(
      _remoteDS.checkVersionUpdate(clear: clear),
    );
    return result!.fold((l) => Left(l), (r) {
      CurrentVersionResponse response = CurrentVersionResponse();
      if (r.isSuccessful()) {
        response = r.data.transform();
        var decryptedData = decryptAESCryptoJS(
            encryptedContent: response.content ?? '', decryptionKey: KeyHelper.DECRYPTION_KEY);
      }
      return Right(r.isSuccessful());
    });
  }

  @override
  Future<Either<DatabaseError, bool>> clearWalletId() async {
    final cleared = await safeDbCall(_localDS.clearWalletId());
    return cleared.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<NetworkError, bool>> sendEmailOTP({required String email, required String password}) async {
    final result = await safeApiCall(
      _remoteDS.sendEmailOTP(email: email, password: password),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> verifyEmailOTP({required String email, required String otpCode}) async {
    final result = await safeApiCall(_remoteDS.verifyEmailOTP(email: email, otpCode: otpCode));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, UpdateJourney>> updateJourney(
      {required UpdateJourneyUseCaseParams params}) async {
    final result = await safeApiCall(_remoteDS.updateJourney(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, CheckJourneyStatus>> updateIdWiseStatus(
      {required CheckJourneyStatusUseCaseUseCaseParams params}) async {
    final result = await safeApiCall(_remoteDS.updateIdWiseStatus(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, ProcessJourney>> processJourneyViaMobile(
      {required ProcessJourneyViaMobileUseCaseParams params}) async {
    final result = await safeApiCall(_remoteDS.processJourneyViaMobile(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<BaseError, bool>> startLocalSession() {
    return Future.value(Right(_localDS.startLocalSession()));
  }

  @override
  Future<Either<BaseError, bool>> endLocalSession() {
    return Future.value(Right(_localDS.endLocalSession()));
  }

  @override
  Future<Either<BaseError, bool>> getLocalSessionWarning(
      Function() onSessionEndWarning, Function() onSessionTimeOut) {
    return Future.value(Right(_localDS.getLocalSessionWarning(onSessionEndWarning, onSessionTimeOut)));
  }
}
