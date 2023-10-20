import 'dart:convert';

import 'package:domain/constants/enum/infobip_utils_enum.dart';
import 'package:flutter/material.dart';

class KeyHelper {
  KeyHelper._();

  ///current version PE decryption key
  static String DECRYPTION_KEY = "1a2b3c4d5e6f7a8b";
  //static String DECRYPTION_KEY = "Htyr3IvDoAhXLg0o";

  ///microblink keys
  static String ANDROID_BLINK_ID = "";
  static String IOS_BLINK_ID = "";

  ///card keys
  static String CARD_DECRYPTION_KEY = "";
  static String PIN_BLOCK_KEY = "";

  ///Credit Card
  static String CREDIT_CARD_PIN_BLOCK_KEY = "";

  ///infobip audio service keys
  static String INFOBIP_APP_KEY = "";
  static String INFOBIP_APPLICATION_CODE = "";
  static String INFOBIP_APPLICATION_ID = "";
  static String INFOBIP_BASE_URL = "";

  ///Dynamic link
  static String DevDynamicLinkPrefix = 'https://blinkcbt.page.link';
  static String UATDynamicLinkPrefix = '';

  static setKeyValues(String content) {
    var mapContent = Map<String, dynamic>();
    mapContent = jsonDecode(content);
    debugPrint('mapContent--->$mapContent');
    CARD_DECRYPTION_KEY = mapContent['dynamicObject']['CardKey'];
    PIN_BLOCK_KEY = mapContent['dynamicObject']['PinblockKey'];
    ANDROID_BLINK_ID = mapContent['dynamicObject']['AndroidKey'];
    IOS_BLINK_ID = mapContent['dynamicObject']['IOSKey'];
    INFOBIP_APP_KEY = mapContent['dynamicObject']['AppKey'];
    INFOBIP_APPLICATION_CODE = mapContent['dynamicObject']['ApplicationCode'];
    INFOBIP_APPLICATION_ID = mapContent['dynamicObject']?['InfobipApplicationId'] ?? '';
    INFOBIP_BASE_URL = mapContent['dynamicObject']?['InfobipBaseUrl'] ?? '';
    CREDIT_CARD_PIN_BLOCK_KEY = mapContent['dynamicObject']?['creditCardPinBlockKey'] ?? '';
    InfobipUtilsConstants.FIREBASE_API_KEY = mapContent['dynamicObject']['FIREBASE_API_KEY'];
    InfobipUtilsConstants.FIREBASE_APPLICATION_ID = mapContent['dynamicObject']['FIREBASE_APPLICATION_ID'];
    InfobipUtilsConstants.FIREBASE_PROJECT_ID = mapContent['dynamicObject']['FIREBASE_PROJECT_ID'];

    debugPrint('Infobip app key--->${INFOBIP_APP_KEY}');
    debugPrint('Infobip app id--->${INFOBIP_APPLICATION_ID}');
    debugPrint('Infobip baseurl--->${INFOBIP_BASE_URL}');
    debugPrint('infobip application code --->${INFOBIP_APPLICATION_CODE}');
    debugPrint('Application id--->${InfobipUtilsConstants.FIREBASE_APPLICATION_ID}');
  }
}
