import 'dart:io';

///this classs provides http client object for API request
class AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    HttpClient client = super.createHttpClient(context);

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
