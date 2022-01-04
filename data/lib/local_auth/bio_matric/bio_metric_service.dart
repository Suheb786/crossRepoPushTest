import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BioMetricService {
  final LocalAuthentication _localAuthentication;

  BioMetricService(this._localAuthentication);

  Future<bool> canCheckBiometric() async {
    return _localAuthentication.isDeviceSupported();
  }

  Future<bool> stopAuthentication() {
    return _localAuthentication.stopAuthentication();
  }

  Future<bool> authenticateWithBiometrics({bool useErrorDialogs: true,
    bool stickyAuth: false,
    String title: "",
    String localisedReason: ""}) async {
    return _localAuthentication.authenticate(
        localizedReason: localisedReason,
        biometricOnly: true,
        androidAuthStrings:
        AndroidAuthMessages(biometricHint: "", signInTitle: title),
        useErrorDialogs: useErrorDialogs,
        stickyAuth: stickyAuth);
  }
}
