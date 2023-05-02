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

  Future<bool> authenticateWithBiometrics(
      {bool useErrorDialogs: true,
      bool stickyAuth: false,
      String title: "",
      String localisedReason: ""}) async {
    // TODO: THIS IS THE ISSUE AND NEEDS TO BE CHECKED!
    // Iterable<AuthMessages> authMessages = const [
    //   AndroidAuthMessages(biometricHint: "", signInTitle: title),
    // ];
    return _localAuthentication.authenticate(
        localizedReason: localisedReason,
        // authMessages: authMessages,
        options: AuthenticationOptions(
            biometricOnly: true,
            // androidAuthStrings: AndroidAuthMessages(biometricHint: "", signInTitle: title),
            useErrorDialogs: useErrorDialogs,
            stickyAuth: stickyAuth));
  }
}
