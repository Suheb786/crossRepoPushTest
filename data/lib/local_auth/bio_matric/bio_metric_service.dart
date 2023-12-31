import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class BioMetricService {
  final LocalAuthentication _localAuthentication;

  BioMetricService(this._localAuthentication);

  Future<bool> canCheckBiometric() async {
    return _localAuthentication.isDeviceSupported();
  }

  Future<bool> stopAuthentication() {
    return _localAuthentication.stopAuthentication();
  }

  Future<bool> authenticateWithBiometrics(
      {bool useErrorDialogs = true,
      bool stickyAuth = false,
      String title = "",
      String localisedReason = ""}) async {
    Iterable<AuthMessages> authMessages = [
      AndroidAuthMessages(biometricHint: "", signInTitle: title),
    ];
    return _localAuthentication.authenticate(
        localizedReason: localisedReason,
        authMessages: authMessages,
        options: AuthenticationOptions(
            biometricOnly: true, useErrorDialogs: useErrorDialogs, stickyAuth: stickyAuth));
  }
}
