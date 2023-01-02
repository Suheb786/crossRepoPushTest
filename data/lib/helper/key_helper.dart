import 'dart:convert';

class KeyHelper {
  KeyHelper._();

  ///current version PE decryption key
  static String DECRYPTION_KEY = "Htyr3IvDoAhXLg0o";

  ///microblink keys
  static String ANDROID_BLINK_ID = "";
  static String IOS_BLINK_ID = "";

  ///card keys
  static String CARD_DECRYPTION_KEY = "";
  static String PIN_BLOCK_KEY = "";

  ///infobip audio service keys
  static String INFOBIP_APP_KEY = "";
  static String INFOBIP_APPLICATION_CODE = "";

  ///Dynamic link
  static String DevDynamicLinkPrefix = 'https://blinkcbt.page.link';
  static String UATDynamicLinkPrefix = '';

  static setKeyValues(String content) {
    var mapContent = Map<String, dynamic>();
    if (content != null) {
      mapContent = jsonDecode(content);
      print('mapContent--->$mapContent');
      CARD_DECRYPTION_KEY = mapContent['dynamicObject']['CardKey'];
      PIN_BLOCK_KEY = mapContent['dynamicObject']['PinblockKey'];
      ANDROID_BLINK_ID = mapContent['dynamicObject']['AndroidKey'];
      IOS_BLINK_ID = mapContent['dynamicObject']['IOSKey'];
      INFOBIP_APP_KEY = mapContent['dynamicObject']['AppKey'];
      INFOBIP_APPLICATION_CODE = mapContent['dynamicObject']['ApplicationCode'];
    }
  }
}
