import 'dart:io';

import 'package:blinkid_flutter/microblink_scanner.dart';
import 'package:dartz/dartz.dart';
import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/helper/key_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/local_auth/bio_matric/bio_metric_service.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';

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
  Future<Either<LocalError, BlinkIdMultiSideRecognizerResult>> scanUserDocument() async {
    var idRecognizer = BlinkIdMultiSideRecognizer();
    idRecognizer.returnFullDocumentImage = true;
    idRecognizer.scanCroppedDocumentImage = true;
    idRecognizer.returnFaceImage = true;

    DocumentVerificationOverlaySettings settings = DocumentVerificationOverlaySettings();
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
        return Left(
            LocalError(message: "No Data Found", cause: Exception("No Data Found"), localError: 1212));

      for (var result in results) {
        if (result is BlinkIdMultiSideRecognizerResult) {
          debugPrint("I AM nationality : ${result.nationality?.description ?? ''}");
          debugPrint("I AM personalIdNumber:  ${result.personalIdNumber?.description ?? ''}");
          debugPrint("I AM documentNumber : ${result.documentNumber?.description ?? ''}");
          debugPrint("I AM firstName : ${result.firstName?.description ?? ''}");
          debugPrint("I AM dateOfExpiry : ${result.dateOfExpiry}");
          debugPrint("I AM dateOfExpiry day: ${result.dateOfExpiry?.date?.day}");
          debugPrint("I AM dateOfExpiry month: ${result.dateOfExpiry?.date?.month}");
          debugPrint("I AM dateOfExpiry year: ${result.dateOfExpiry?.date?.year}");
          debugPrint("I AM dateOfBirth : ${result.dateOfBirth}");
          debugPrint("I AM dateOfBirth day : ${result.dateOfBirth?.date?.day}");
          debugPrint("I AM dateOfBirth month : ${result.dateOfBirth?.date?.month}");
          debugPrint("I AM dateOfBirth year : ${result.dateOfBirth?.date?.year}");
          debugPrint("I AM sex:  ${result.sex?.description ?? ''}");
          debugPrint("I AM sex:  ${result.sex?.stringsByAlphabet[AlphabetType.Latin] ?? ''}");
          debugPrint("I AM sex:  ${result.sex?.stringsByAlphabet ?? ''}");
          debugPrint("I AM fullName:  ${result.fullName?.description ?? ''}");
          debugPrint("I AM placeOfBirth:  ${result.placeOfBirth?.description ?? ''}");
          debugPrint(
              "I AM placeOfBirth:  ${result.placeOfBirth?.stringsByAlphabet[AlphabetType.Latin] ?? ''}");
          debugPrint(
              "I AM additionalAddressInformation : ${result.additionalAddressInformation?.description ?? ''}");
          debugPrint("I AM address : ${result.address?.description ?? ''}");
          debugPrint("I AM age:  ${result.age}");
          debugPrint(
              "I AM additionalNameInformation : ${result.additionalNameInformation?.description ?? ''}");
          debugPrint("I AM dateOfIssue : ${result.dateOfIssue}");
          debugPrint("I AM dateOfIssue day : ${result.dateOfIssue?.date?.day}");
          debugPrint("I AM dateOfIssue month : ${result.dateOfIssue?.date?.month}");
          debugPrint("I AM dateOfIssue year : ${result.dateOfIssue?.date?.year}");
          debugPrint("I AM fathersName:  ${result.fathersName?.description ?? ''}");
          debugPrint("I AM mothersName : ${result.mothersName?.description ?? ''}");

          debugPrint("I AM mrzResult Gender :${result.mrzResult!.gender}");
          debugPrint("I AM mrzResult documentNumber :${result.mrzResult?.documentNumber}");
          debugPrint("I AM mrzResult Date of Expiry :${result.mrzResult?.dateOfExpiry}");
          debugPrint("I AM mrzResult nationality :${result.mrzResult?.nationality}");
          debugPrint("I AM mrzResult mrzVerified:${result.mrzResult?.mrzVerified}");
          debugPrint("I AM mrzResult mrzParsed :${result.mrzResult?.mrzParsed}");
          debugPrint("I AM mrzResult issuer :${result.mrzResult?.issuer}");
          debugPrint("I AM mrzResult dateOfBirth :${result.mrzResult?.dateOfBirth}");
          debugPrint("I AM mrzResult dateOfBirth day :${result.mrzResult?.dateOfBirth?.day}");
          debugPrint("I AM mrzResult dateOfBirth month :${result.mrzResult?.dateOfBirth?.month}");
          debugPrint("I AM mrzResult dateOfBirth year :${result.mrzResult?.dateOfBirth?.year}");

          debugPrint("I AM mrzResult age :${result.mrzResult?.age}");
          debugPrint("I AM mrzResult mrzText :${result.mrzResult?.mrzText}");
          debugPrint("I AM mrzResult alienNumber :${result.mrzResult?.alienNumber}");
          debugPrint(
              "I AM mrzResult applicationReceiptNumber :${result.mrzResult?.applicationReceiptNumber}");
          debugPrint("I AM mrzResult documentCode :${result.mrzResult?.documentCode}");
          debugPrint("I AM mrzResult documentType :${result.mrzResult?.documentType}");
          debugPrint("I AM mrzResult immigrantCaseNumber :${result.mrzResult?.immigrantCaseNumber}");
          debugPrint("I AM mrzResult opt1 :${result.mrzResult?.opt1}");
          debugPrint("I AM mrzResult opt2 :${result.mrzResult?.opt2}");
          debugPrint("I AM mrzResult primaryId :${result.mrzResult?.primaryId}");
          debugPrint("I AM mrzResult sanitizedDocumentCode :${result.mrzResult?.sanitizedDocumentCode}");
          debugPrint("I AM mrzResult sanitizedDocumentNumber :${result.mrzResult?.sanitizedDocumentNumber}");
          debugPrint("I AM mrzResult sanitizedIssuer :${result.mrzResult?.sanitizedIssuer}");
          debugPrint("I AM mrzResult sanitizedNationality :${result.mrzResult?.sanitizedNationality}");
          debugPrint("I AM mrzResult sanitizedOpt1 :${result.mrzResult?.sanitizedOpt1}");
          debugPrint("I AM mrzResult sanitizedOpt2 :${result.mrzResult?.sanitizedOpt2}");
          debugPrint("I AM mrzResult secondaryId :${result.mrzResult?.secondaryId}");
          debugPrint("I AM frontfullDocumentImage  :${result.fullDocumentFrontImage}");
          debugPrint("I AM backfullDocumentImage  :${result.fullDocumentBackImage}");

          DateTime currentTime = DateTime.now();

          DateTime expiryDate = DateTime(
              result.dateOfExpiry != null ? result.dateOfExpiry!.date!.year! : currentTime.year,
              result.dateOfExpiry != null ? result.dateOfExpiry!.date!.month! : currentTime.month,
              result.dateOfExpiry != null ? result.dateOfExpiry!.date!.day! : currentTime.day);

          if (currentTime.toUtc().isAfter(expiryDate.toUtc())) {
            return Left(LocalError(cause: Exception(""), localError: 1211, message: ""));
          }
          return Right(result);
        }
      }
      return Right(BlinkIdMultiSideRecognizerResult(Map()));
    } on Exception catch (e) {
      debugPrint("I AM HERE ${e}");
      return Left(LocalError(
          cause: Exception("Some error occurred while processing. Please try again later"),
          localError: 1212,
          message: "Some error occurred while processing. Please try again later"));
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

  @override
  Future<bool> clearWalletId() async {
    return await _secureStorageHelper.clearWalletId();
  }
}
