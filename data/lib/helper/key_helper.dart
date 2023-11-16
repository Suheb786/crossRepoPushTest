import 'dart:convert';

import 'package:domain/constants/enum/infobip_utils_enum.dart';
import 'package:flutter/material.dart';

class KeyHelper {
  KeyHelper._();

  ///current version PE decryption key
  static String DECRYPTION_KEY = "1a2b3c4d5e6f7a8b";

  //static String DECRYPTION_KEY = "Htyr3IvDoAhXLg0o";

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

  ///IDWise Keys
  static String ID_Wise_Client_ID = '';
  static String ID_Journey_Client_ID = '';
  static Duration MAIN_TIMEOUT = Duration(minutes: 3);
  static Duration WARNING_TIMEOUT = Duration(minutes: 1);

  ///Timeout
  static String API_RETRY_TIMEOUT = '3';

  static setKeyValues(String content) {
    var mapContent = Map<String, dynamic>();

    mapContent = jsonDecode(content);
    // mapContent['dynamicObject'].keys.forEach((element) {
    //   print('Keys---->$element');
    // });
    // debugPrint('mapContent--->$mapContent');
    CARD_DECRYPTION_KEY = mapContent['dynamicObject']['CardKey'];
    PIN_BLOCK_KEY = mapContent['dynamicObject']['PinblockKey'];
    INFOBIP_APP_KEY = mapContent['dynamicObject']['AppKey'];
    INFOBIP_APPLICATION_CODE = mapContent['dynamicObject']['ApplicationCode'];
    INFOBIP_APPLICATION_ID = mapContent['dynamicObject']?['InfobipApplicationId'] ?? '';
    INFOBIP_BASE_URL = mapContent['dynamicObject']?['InfobipBaseUrl'] ?? '';
    CREDIT_CARD_PIN_BLOCK_KEY = mapContent['dynamicObject']?['creditCardPinBlockKey'] ?? '';
    ID_Wise_Client_ID = mapContent['dynamicObject']?['IDWisecClientId'] ?? '';
    ID_Journey_Client_ID = mapContent['dynamicObject']?['IDWiseJourneyDefinitionId'] ?? '';
    API_RETRY_TIMEOUT = mapContent['dynamicObject']?['ApiRetry'] ?? '3';
    InfobipUtilsConstants.FIREBASE_API_KEY = mapContent['dynamicObject']['FIREBASE_API_KEY'];
    InfobipUtilsConstants.FIREBASE_APPLICATION_ID = mapContent['dynamicObject']['FIREBASE_APPLICATION_ID'];
    InfobipUtilsConstants.FIREBASE_PROJECT_ID = mapContent['dynamicObject']['FIREBASE_PROJECT_ID'];

    MAIN_TIMEOUT = Duration(minutes: int.tryParse(mapContent["dynamicObject"]?['TokenTimeOut'] ?? "3") ?? 3);
    WARNING_TIMEOUT = MAIN_TIMEOUT - Duration(minutes: 1);

    debugPrint('Infobip app key--->${INFOBIP_APP_KEY}');
    debugPrint('Infobip app id--->${INFOBIP_APPLICATION_ID}');
    debugPrint('Infobip baseurl--->${INFOBIP_BASE_URL}');
    debugPrint('infobip application code --->${INFOBIP_APPLICATION_CODE}');
    debugPrint('Application id--->${InfobipUtilsConstants.FIREBASE_APPLICATION_ID}');
    debugPrint('ID_Wise_Client_ID--->${ID_Wise_Client_ID}');
    debugPrint('ID_Journey_Client_ID--->${ID_Journey_Client_ID}');
  }
}
