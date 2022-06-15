import 'dart:io';

import 'package:blinkid_flutter/microblink_scanner.dart';
import 'package:blinkid_flutter/overlays/blinkid_overlays.dart';
import 'package:blinkid_flutter/recognizer.dart';
import 'package:blinkid_flutter/recognizers/blink_id_combined_recognizer.dart';
import 'package:dartz/dartz.dart';
import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/helper/key_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/local_auth/bio_matric/bio_metric_service.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/user/user.dart';

class UserLocalDSImpl extends UserLocalDS {
  final BioMetricService _bioMetricService;
  final SecureStorageHelper _secureStorageHelper;

  UserLocalDSImpl(this._bioMetricService, this._secureStorageHelper);

  @override
  Future<User?> getCurrentUser() async {
    User? user = await _secureStorageHelper.getUserDataFromSecureStorage();
    if (user == null) {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.NO_USER_FOUND,
      );
    }

    return user;
  }

  @override
  Future<bool> removeUser() async {
    return await _secureStorageHelper.clearUserData();
  }

  @override
  Future<bool> saveCurrentUser(User user) async {
    return await _secureStorageHelper.saveUserToSecureStorage(user: user);
  }

  @override
  Future<Either<LocalError, BlinkIdCombinedRecognizerResult>>
      scanUserDocument() async {
    var idRecognizer = BlinkIdCombinedRecognizer();
    idRecognizer.returnFullDocumentImage = true;
    idRecognizer.scanCroppedDocumentImage = true;
    idRecognizer.returnFaceImage = true;

    DocumentVerificationOverlaySettings settings =
        DocumentVerificationOverlaySettings();
    settings.firstSideInstructions =
        'Front ID\nID will be scanned automatically when placed within the frame';
    settings.secondSideInstructions =
        'Back ID\nID will be scanned automatically when placed within the frame';
    settings.enableBeep = true;
    settings.firstSideSplashMessage = 'Scanning...';
    settings.scanningDoneSplashMessage = 'Scan successful';
    settings.secondSideSplashMessage = 'Scanning...';

    try {
      List<RecognizerResult> results = await MicroblinkScanner.scanWithCamera(
          RecognizerCollection([idRecognizer]),
          settings,
          Platform.isIOS
              ? KeyHelper.IOS_BLINK_ID
              : Platform.isAndroid
                  ? KeyHelper.ANDROID_BLINK_ID
                  : "");

      if (results.length == 0)
        return Left(LocalError(
            message: "No Data Found",
            cause: Exception("No Data Found"),
            localError: 1212));

      for (var result in results) {
        if (result is BlinkIdCombinedRecognizerResult) {
          print("I AM nationality : ${result.nationality}");
          print("I AM personalIdNumber:  ${result.personalIdNumber}");
          print("I AM documentNumber : ${result.documentNumber}");
          print("I AM firstName : ${result.firstName}");
          print("I AM dateOfExpiry : ${result.dateOfExpiry}");
          print("I AM dateOfBirth : ${result.dateOfBirth}");
          print("I AM sex:  ${result.sex}");
          print("I AM fullName:  ${result.fullName}");
          print(
              "I AM additionalAddressInformation : ${result.additionalAddressInformation}");
          print("I AM address : ${result.address}");
          print("I AM age:  ${result.age}");
          print(
              "I AM additionalNameInformation : ${result.additionalNameInformation}");
          print("I AM dateOfIssue : ${result.dateOfIssue}");
          // print("I AM dateOfIssue day : ${result.dateOfIssue!.day}");
          // print("I AM dateOfIssue month : ${result.dateOfIssue!.month}");
          // print("I AM dateOfIssue year : ${result.dateOfIssue!.year}");
          print("I AM fathersName:  ${result.fathersName}");
          print("I AM mothersName : ${result.mothersName}");

          print("I AM mrzResult Gender :${result.mrzResult!.gender}");
          print(
              "I AM mrzResult documentNumber :${result.mrzResult!.documentNumber}");
          print(
              "I AM mrzResult Date of Expiry :${result.mrzResult!.dateOfExpiry}");
          print("I AM mrzResult nationality :${result.mrzResult!.nationality}");
          print("I AM mrzResult mrzVerified:${result.mrzResult!.mrzVerified}");
          print("I AM mrzResult mrzParsed :${result.mrzResult!.mrzParsed}");
          print("I AM mrzResult issuer :${result.mrzResult!.issuer}");
          print("I AM mrzResult dateOfBirth :${result.mrzResult!.dateOfBirth}");
          print("I AM mrzResult age :${result.mrzResult!.age}");
          print("I AM mrzResult mrzText :${result.mrzResult!.mrzText}");
          print("I AM mrzResult alienNumber :${result.mrzResult!.alienNumber}");
          print(
              "I AM mrzResult applicationReceiptNumber :${result.mrzResult!.applicationReceiptNumber}");
          print(
              "I AM mrzResult documentCode :${result.mrzResult!.documentCode}");
          print(
              "I AM mrzResult documentType :${result.mrzResult!.documentType}");
          print(
              "I AM mrzResult immigrantCaseNumber :${result.mrzResult!.immigrantCaseNumber}");
          print("I AM mrzResult opt1 :${result.mrzResult!.opt1}");
          print("I AM mrzResult opt2 :${result.mrzResult!.opt2}");
          print("I AM mrzResult primaryId :${result.mrzResult!.primaryId}");
          print(
              "I AM mrzResult sanitizedDocumentCode :${result.mrzResult!.sanitizedDocumentCode}");
          print(
              "I AM mrzResult sanitizedDocumentNumber :${result.mrzResult!.sanitizedDocumentNumber}");
          print(
              "I AM mrzResult sanitizedIssuer :${result.mrzResult!.sanitizedIssuer}");
          print(
              "I AM mrzResult sanitizedNationality :${result.mrzResult!.sanitizedNationality}");
          print(
              "I AM mrzResult sanitizedOpt1 :${result.mrzResult!.sanitizedOpt1}");
          print(
              "I AM mrzResult sanitizedOpt2 :${result.mrzResult!.sanitizedOpt2}");
          print("I AM mrzResult secondaryId :${result.mrzResult!.secondaryId}");

          DateTime currentTime = DateTime.now();

          DateTime expiryDate = DateTime(
              result.dateOfExpiry != null
                  ? result.dateOfExpiry!.year!
                  : currentTime.year,
              result.dateOfExpiry != null
                  ? result.dateOfExpiry!.month!
                  : currentTime.month,
              result.dateOfExpiry != null
                  ? result.dateOfExpiry!.day!
                  : currentTime.day);

          if (currentTime.toUtc().isAfter(expiryDate.toUtc())) {
            return Left(LocalError(
                cause: Exception(""), localError: 1211, message: ""));
          }
          return Right(result);
        }
      }
      return Right(BlinkIdCombinedRecognizerResult(Map()));
    } on Exception catch (e) {
      print("I AM HERE ${e}");
      return Left(LocalError(
          cause: Exception(
              "Some error occurred while processing. Please try again later"),
          localError: 1212,
          message:
              "Some error occurred while processing. Please try again later"));
    }
  }

  @override
  Future<bool> checkBioMetricSupport() {
    try {
      return _bioMetricService.canCheckBiometric();
    } catch (exception) {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.NO_BIO_METRIC_SUPPORT,
      );
    }
  }

  @override
  Future<bool> authenticateBioMetric(String title, String localisedReason) {
    try {
      return _bioMetricService.authenticateWithBiometrics(
        title: title,
        localisedReason: localisedReason,
      );
    } catch (exception) {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.BIO_METRIC_FAIL,
      );
    }
  }
}
