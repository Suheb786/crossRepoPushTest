import 'dart:io';

import 'package:blinkid_flutter/microblink_scanner.dart';
import 'package:blinkid_flutter/overlays/blinkid_overlays.dart';
import 'package:blinkid_flutter/recognizer.dart';
import 'package:blinkid_flutter/recognizers/blink_id_combined_recognizer.dart';
import 'package:dartz/dartz.dart';
import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/db/floor/app_database.dart';
import 'package:data/db/floor/floor_db_service.dart';
import 'package:data/entity/local/base/scanner_helper.dart';
import 'package:data/entity/local/user_db_entity.dart';
import 'package:data/local_auth/bio_matric/bio_metric_service.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/error/local_error.dart';

class UserLocalDSImpl extends UserLocalDS {
  final FloorDbService floorDbService;
  final BioMetricService _bioMetricService;

  UserLocalDSImpl(this.floorDbService, this._bioMetricService);

  @override
  Future<Stream<UserDBEntity?>> listenCurrentUser() async {
    return (await _getAppDatabase())!.userDao.listenCurrentUser();
  }

  Future<AppDatabase?> _getAppDatabase() {
    return floorDbService.db;
  }

  @override
  Future<UserDBEntity?> getCurrentUser() async {
    UserDBEntity? userDBEntity =
        await (await _getAppDatabase())!.userDao.getCurrentUser();
    if (userDBEntity == null) {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.NO_USER_FOUND,
      );
    }

    return userDBEntity;
  }

  @override
  Future<bool> removeUser() async {
    return (await (await _getAppDatabase())!.userDao.deleteUser());
  }

  @override
  Future<bool> saveCurrentUser(UserDBEntity userDBEntity) async {
    return (await (await _getAppDatabase())!.userDao.insertUser(userDBEntity));
  }

  @override
  Future<Either<LocalError, BlinkIdCombinedRecognizerResult>>
      scanUserDocument() async {
    var idRecognizer = BlinkIdCombinedRecognizer();
    idRecognizer.returnFullDocumentImage = true;
    idRecognizer.scanCroppedDocumentImage = true;

    DocumentVerificationOverlaySettings settings =
        DocumentVerificationOverlaySettings();
    settings.firstSideInstructions =
        'Place the front of your ID. It will scan automatically';
    settings.secondSideInstructions =
        'Place the back side of your ID. It will scan automatically';
    settings.enableBeep = true;

    try {
      List<RecognizerResult> results = await MicroblinkScanner.scanWithCamera(
          RecognizerCollection([idRecognizer]),
          settings,
          Platform.isIOS
              ? ScannerHelper.IOS_BLINK_ID
              : Platform.isAndroid
                  ? ScannerHelper.ANDROID_BLINK_ID
                  : "");

      if (results.length == 0)
        return Left(LocalError(
            message: "No Data Found",
            cause: Exception("No Data Found"),
            localError: 1212));

      for (var result in results) {
        if (result is BlinkIdCombinedRecognizerResult) {
          return Right(result);
        }
      }
      return Right(BlinkIdCombinedRecognizerResult(Map()));
    } on Exception {
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
