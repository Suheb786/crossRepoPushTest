import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';

class AppFlyerHelper {
  AppsflyerSdk? _appsFlyerSdk;

  bool initSdk() {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
        afDevKey: "so5FCeH5icgTCmHUVrPuc6",
        appId: Platform.isAndroid ? "com.blink.cbt" : "1607969058",
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
      if (_appsFlyerSdk != null) {
        result = await _appsFlyerSdk?.logEvent(eventName, eventValues);
        if (result ?? false) {
          debugPrint("Result logEvent if--------: $result");
          return true;
        } else {
          return false;
        }
      } else {
        initSdk();
        result = await _appsFlyerSdk?.logEvent(eventName, eventValues);
        if (result ?? false) {
          debugPrint("Result logEvent else--------: $result");
          return true;
        } else {
          return false;
        }
      }
    } on Exception catch (e) {
      debugPrint("Result logEvent--------: ${e}");
      return false;
    }
  }
}
