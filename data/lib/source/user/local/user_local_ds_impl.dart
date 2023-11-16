import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/local_auth/bio_matric/bio_metric_service.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:domain/model/user/user.dart';

import '../../../network/local_session_service.dart';

class UserLocalDSImpl extends UserLocalDS {
  final BioMetricService _bioMetricService;
  final SecureStorageHelper _secureStorageHelper;
  final LocalSessionService _localSessionService;

  UserLocalDSImpl(this._bioMetricService, this._secureStorageHelper, this._localSessionService);

  @override
  Future<User> getCurrentUser() async {
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

  @override
  bool endLocalSession() {
    return _localSessionService.stopTimer();
  }

  @override
  bool getLocalSessionWarning(Function() onSessionEndWarning, Function() onSessionTimeOut) {
    return _localSessionService.startTimer();
  }

  @override
  bool startLocalSession() {
    return _localSessionService.startTimer();
  }
}
