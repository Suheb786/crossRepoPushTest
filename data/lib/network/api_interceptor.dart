import 'package:data/helper/encypt_decrypt_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:dio/dio.dart';
import 'package:domain/constants/app_constants_domain.dart';
import 'package:domain/repository/user/user_repository.dart';

class ApiInterceptor extends InterceptorsWrapper {
  final UserRepository _userRepository;
  final Dio _previousDio;
  late ApiService apiService;
  String authToken = "";

  late Set<String> verifiedURLs = {};
  Future<String>? secure = Future.value('');

  ApiInterceptor(this._userRepository, this._previousDio) {
    Dio newDio = Dio(_previousDio.options);
    newDio.interceptors.add(_previousDio.interceptors.first);
    apiService = ApiService(newDio, baseUrl: NetworkProperties.BASE_CHANNEL_URL);
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.putIfAbsent("Authorization", () => "Bearer $authToken");
    // if (options.uri.path.contains("GetBillerLookupList")) {
    options.headers.putIfAbsent("Lang", () => AppConstantsDomain.SELECTED_LANGUAGE);
    print('Lang--->${AppConstantsDomain.SELECTED_LANGUAGE}');
    // }
    print('authToken--->$authToken');

    /// TODO::: UNCOMMENT BELOW LINE FOR ENCRYPTION OF REQUEST DATA
    options.data = _encryptRequest(options.data);

    ///PIN BLOCK TEST

    /*String encryptedCard = EncryptDecryptHelper.encryptCard(cardNo: '4082230008847333');
    print('encryptedCard------>$encryptedCard');

    String decryptedCard = EncryptDecryptHelper.decryptCard(cardNo: 'q1FqpOl9dwa+8n8FRHP3xS4k7rha70mu');
    print('decryptedCard------>$decryptedCard');*/

    ///TODO:: UNCOMMENT BELOW BLOCK FOR SSL PINNING
/*
    try {
      // skip verification if already verified, performance
      if (verifiedURLs.contains(options.baseUrl)) {
        return handler.next(options);
      }
      // iOS bug: Alamofire is failing to return parallel requests for certificate validation
      if (Platform.isIOS && secure != null) {
        await secure;
      }

      List<String> _allowedSHAFingerprints = [];

      if (options.baseUrl == NetworkProperties.BASE_CHANNEL_URL) {
        _allowedSHAFingerprints.add(
            "AC:A5:99:D8:DD:74:7A:96:C5:41:AA:1F:2F:4C:53:98:52:39:8B:81:4B:DF:1C:95:F9:5F:D7:D4:D9:C9:66:7D");
      } else if (options.baseUrl == NetworkProperties.BASE_ROUTER_URL) {
        _allowedSHAFingerprints.add(
            "22:DE:99:9C:72:77:FE:8D:2D:B2:53:30:6D:7A:42:7A:19:B9:14:A1:AC:FE:81:D7:BB:20:D0:F0:34:A7:63:E5");
      }

      secure = HttpCertificatePinning.check(
        serverURL: options.baseUrl,
        headerHttp: options.headers.map((a, b) => MapEntry(a, b.toString())),
        sha: SHA.SHA256,
        allowedSHAFingerprints: _allowedSHAFingerprints,
        timeout: 0,
      );

      secure?.whenComplete(() => secure = null);
      final secureString = await secure ?? '';

      if (secureString.contains('CONNECTION_SECURE')) {
        verifiedURLs.add(options.baseUrl);
        return handler.next(options);
      } else {
        handler.reject(
          DioError(
            requestOptions: options,
            error: CertificateNotVerifiedException(),
          ),
        );
      }
    } on Exception catch (e) {
      dynamic error;

      if (e is PlatformException && e.code == 'CONNECTION_NOT_SECURE') {
        error = const CertificateNotVerifiedException();
      } else {
        error = CertificateCouldNotBeVerifiedException(e);
      }

      handler.reject(
        DioError(
          requestOptions: options,
          error: error,
        ),
      );
    }*/

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response!.statusCode == 401) {
      authToken = '';
      return super.onError(err, handler);
    }
    if (err.response!.data != null) {
      if (((err.response!.data as Map<String, dynamic>)['response']['token'] as String?)?.isNotEmpty ??
          false) {
        authToken = (err.response!.data as Map<String, dynamic>)['response']['token'] ?? '';
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      authToken = '';
      return super.onResponse(response, handler);
    }
    if (response.realUri.path.contains('logout')) {
      authToken = '';
      return super.onResponse(response, handler);
    }
    if (response.statusCode == 200) {
      if (response.data != null) {
        if (((response.data as Map<String, dynamic>)['response']['token'] as String?)?.isNotEmpty ?? false) {
          authToken = (response.data as Map<String, dynamic>)['response']['token'] ?? '';
        }
      }
    }

    super.onResponse(response, handler);
  }
}

Map<String, dynamic> _encryptRequest(Map<String, dynamic> data) {
  return EncryptDecryptHelper.encryptRequest(data);
}
