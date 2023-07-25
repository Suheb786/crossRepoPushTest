import 'package:data/helper/encypt_decrypt_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:dio/dio.dart';
import 'package:domain/constants/app_constants.dart';
import 'package:domain/constants/app_constants_domain.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends InterceptorsWrapper {
  final Dio _previousDio;
  late ApiService apiService;
  String authToken = "";

  late Set<String> verifiedURLs = {};
  Future<String>? secure = Future.value('');

  ApiInterceptor(this._previousDio) {
    Dio newDio = Dio(_previousDio.options);
    newDio.interceptors.add(_previousDio.interceptors.first);
    apiService = ApiService(newDio, baseUrl: NetworkProperties.BASE_CHANNEL_URL);
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (authToken.isEmpty) {
      authToken = (await SecureStorageHelper.instance.getToken()) ?? '';
    }
    options.headers.putIfAbsent("Authorization", () => "Bearer $authToken");

    if (options.uri.path.toLowerCase().contains("login")) {
      authToken = "";
      AppConstants.IS_BACKGROUND_API_IN_PROGRESS = false;
    }

    options.headers.putIfAbsent("suspendToken", () => AppConstants.IS_BACKGROUND_API_IN_PROGRESS);
    options.headers.putIfAbsent("Lang", () => AppConstantsDomain.SELECTED_LANGUAGE);
    options.headers.putIfAbsent("appSignature", () => AppConstantsDomain.APP_SIGNATURE);
    debugPrint('Lang--->${AppConstantsDomain.SELECTED_LANGUAGE}');
    debugPrint('App Signature--->${AppConstantsDomain.APP_SIGNATURE}');

    debugPrint('authToken--->$authToken');
    debugPrint('suspended Token  --->${AppConstants.IS_BACKGROUND_API_IN_PROGRESS}');

    if (options.data != null) {
      options.data = _encryptRequest(options.data);
    }

    debugPrint('headers auth token------>${options.headers}');

    ///PIN BLOCK TEST

    String encryptedCard = EncryptDecryptHelper.encryptCard(cardNo: '4082230006238493');
    print('encryptedCard------>$encryptedCard');

    String pinBlock =
        EncryptDecryptHelper.generateBlockPinForCreditCard(cardNo: '4082230006238493', pinCode: '5678');
    debugPrint('pinBlock------>$pinBlock');

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response!.statusCode == 401) {
      authToken = '';
      SecureStorageHelper.instance.clearToken();
      return super.onError(err, handler);
    }
    if (err.response!.data != null) {
      if (((err.response!.data as Map<String, dynamic>)['response']['token'] as String?)?.isNotEmpty ??
          false) {
        if ((err.response!.data as Map<String, dynamic>)['response']['token'] != 'Error') {
          authToken = (err.response!.data as Map<String, dynamic>)['response']['token'] ?? '';
          SecureStorageHelper.instance.storeTokenId(token: authToken);
        }
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      authToken = '';
      SecureStorageHelper.instance.clearToken();
      return super.onResponse(response, handler);
    }
    if (response.realUri.path.contains('logout')) {
      authToken = '';
      SecureStorageHelper.instance.clearToken();
      return super.onResponse(response, handler);
    }
    if (response.statusCode == 200) {
      if (response.data != null) {
        if (((response.data as Map<String, dynamic>)['response']['token'] as String?)?.isNotEmpty ?? false) {
          if ((response.data as Map<String, dynamic>)['response']['token'] != 'Error') {
            authToken = (response.data as Map<String, dynamic>)['response']['token'] ?? '';
            SecureStorageHelper.instance.storeTokenId(token: authToken);
          }
        }
      }
    }

    super.onResponse(response, handler);
  }
}

Map<String, dynamic> _encryptRequest(Map<String, dynamic> data) {
  return EncryptDecryptHelper.encryptRequest(data);
}
