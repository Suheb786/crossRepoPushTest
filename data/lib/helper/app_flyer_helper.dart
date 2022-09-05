import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';

class AppFlyerHelper {
  AppsflyerSdk? _appsFlyerSdk;

  bool initSdk() {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
        afDevKey: "so5FCeH5icgTCmHUVrPuc6",
        appId: "com.blink.cbt",
        timeToWaitForATTUserAuthorization: 50,
        disableAdvertisingIdentifier: false,
        disableCollectASA: false,

        ///TODO:change for production to false(testing purpose only)
        showDebug: true);
    _appsFlyerSdk = AppsflyerSdk(appsFlyerOptions);
    _appsFlyerSdk?.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
    return true;
  }

  Future<bool> logEvent(String eventName, Map? eventValues) async {
    bool? result;
    try {
      result = await _appsFlyerSdk?.logEvent(eventName, eventValues);
      if (result ?? false) {
        debugPrint("Result logEvent--------: $result");
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint("Result logEvent--------: ${e}");
      return false;
    }
  }
}
