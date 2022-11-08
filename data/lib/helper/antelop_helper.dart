import 'dart:convert';
import 'dart:math';

import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/source/apple_pay/apple_pay_datasource.dart';
import 'package:domain/model/user/user.dart';
import 'package:eventify/eventify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AntelopHelper {
  static const platform = const MethodChannel('com.capital.cbt');
  String result = '';
  bool showText = false;

  final ApplePayRemoteDataSource _applePayRemoteDataSource;
  EventChannel eventChannel = EventChannel("continueListining");
  final EventEmitter _eventEmitter = EventEmitter();
  String antelopWalletId = '';
  static String constantAuthToken = "";

  AntelopHelper(this._applePayRemoteDataSource) {
    registerAntelopEvents();
    registerSdkCalback();
    getWalletId();
  }

  getWalletId() async {
    var id = await SecureStorageHelper.instance.getWalletId();
    if ((id ?? '').isNotEmpty) {
      antelopWalletId = id ?? '';
    }
  }

  registerSdkCalback() {
    on("onConnectionSuccess", onConnectionSuccessWallet);
  }

  void registerAntelopEvents() {
    eventChannel.receiveBroadcastStream().listen((data) {
      debugPrint('REGISTERRDANEVENTS $data');
      _parseEventData(data);
    });
  }

  void on(String event, Function handler) {
    EventCallback cb = (event, cont) {
      handler(event.eventData);
    };
    _eventEmitter.on(event, null, cb);
  }

  onConnectionSuccessWallet(var data) {
    debugPrint(data.toString());
  }

  Future<bool> onInitializationFromNative() async {
    try {
      var data = await platform.invokeMethod('initialize');
      return true;
    } on PlatformException catch (e) {
      debugPrint('Failed to get version: ${e.message}');
      return false;
    }
  }

  Future<void> _parseEventData(Map response) async {
    String eventName = response["eventName"];
    String data = response["response"];
    debugPrint('eventName ---> event data --> $eventName $data');

    switch (eventName) {
      case "onInitializationSuccess":
        debugPrint('onInitializationSuccess callback Flutter side');
        Map newData = jsonDecode(data);
        debugPrint('Flutter onInitializationSuccess' + newData.toString());
        var deviceEligible = await platform.invokeMethod('checkEligibility');
        break;

      case "onInitializationError":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onInitializationError" + newData.toString());
        break;

      case "onDeviceEligible":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onDeviceEligible-----> " + newData.toString());
        String clientId = '';
        String phoneNumber = '';
        User? user = await SecureStorageHelper.instance.getUserDataFromSecureStorage();
        if (user != null) {
          clientId = user.id ?? '';
          phoneNumber = "${user.mobileCode ?? ''}${user.mobile ?? ''}";
        }

        if (antelopWalletId.isEmpty) {
          String randomWalletId = RandomDigits.getInteger(16).toString();
          debugPrint("randomWalletId----> $randomWalletId");
          var parameter = {
            "clientId": clientId,
            "walletId": randomWalletId,
            "settingsProfileId": "blink",
            // "phoneNumber": "+962123456789",
            "phoneNumber": phoneNumber
          };
          debugPrint("on device eligible parameter--->${parameter.toString()}");
          var launchData = await platform.invokeMethod('getWalletLaunch', parameter);
        } else {
          var walletConnect = await platform.invokeMethod('walletConnect');
        }
        break;

      case "onCheckEligibilityError":
        Map newData = jsonDecode(data);
        debugPrint("On device eligibility error------>${newData.toString()}");
        break;

      case "onDeviceNotEligible":
        Map newData = jsonDecode(data);
        debugPrint("onDeviceNotEligible ------>${newData.toString()}");
        break;

      case "onProvisioningSuccess":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onProvisioningSuccess " + newData.toString());
        var walletConnect = await platform.invokeMethod('walletConnect');
        break;

      case "onProvisioningError":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onProvisioningError " + newData.toString());
        break;

      case "onConnectionError":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onConnectionError " + newData.toString());
        break;

      case "onProvisioningRequired":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onProvisioningRequired " + newData.toString());
        break;

      case "onCredentialsRequired":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onCredentialsRequired " + newData.toString());
        break;

      case "onAsyncRequestError":
        Map newData = jsonDecode(data);
        debugPrint(newData.toString());
        break;

      case "onAsyncRequestSuccess":
        Map newData = jsonDecode(data);
        debugPrint(newData.toString());
        break;

      case "onConnectionSuccess":
        debugPrint('MethodKeys.EVENT_ON_INITIALIZE_PROGRESS ---> event data --> $data');
        Map walletData = jsonDecode(data);
        debugPrint(walletData.toString());
        debugPrint("walletId " + walletData["walletId"].toString());
        debugPrint("getIssuerWalletId " + walletData["getIssuerWalletId"].toString());
        debugPrint("getIssuerClientId " + walletData["getIssuerClientId"].toString());

        antelopWalletId = walletData["walletId"].toString();

        ///saving wallet id
        await SecureStorageHelper.instance.saveWalletId(walletId: walletData["walletId"].toString());

        if (walletData["walletId"] != '') {
          _applePayRemoteDataSource
              .enrollCards(
                  walletId: walletData["walletId"] != null ? walletData["walletId"].toString() : "",
                  cardType: "C",
                  cardId: "")
              .then((value) async {
            debugPrint("Final enroll Card length---> " + value.data.content?.cards?.length);
            debugPrint("Final  enroll Card ---> " + value.data.content?.cards?[0]);

            var parameter = {"enrollmentData": value.data.content?.cards?[0].enrollmentData};
            var data = await platform.invokeMethod('enrollCard', parameter);
          }, onError: (error) async {
            debugPrint("MainError-----------> ${error.toString()}");
            var cardsData = await platform.invokeMethod('getAllCards');
          });
        } else {
          var cardsData = await platform.invokeMethod('getAllCards');
        }
        _eventEmitter.emit(eventName, null, result);
        break;

      case "getCards":
        debugPrint("Flutter side getCards " + data.toString());
        Map newData = jsonDecode(data);
        debugPrint(newData.toString());
        break;

      case "enrollCardSuccess":
        debugPrint("Flutter side enrollCardSuccess " + data.toString());
        var cardsData = await platform.invokeMethod('getAllCards');
        break;

      case "enrollCardError":
        var cardsData = await platform.invokeMethod('getAllCards');
        debugPrint("Flutter side enrollCardError " + data.toString());

        break;

      case "enrollCardCatch":
        var cardsData = await platform.invokeMethod('getAllCards');
        debugPrint("Flutter side enrollCardCatch " + data.toString());
        break;

      default:
        _eventEmitter.emit(eventName, null, data);
        break;
    }
  }
}

class RandomDigits {
  static const MaxNumericDigits = 16;
  static final _random = Random();

  static int getInteger(int digitCount) {
    if (digitCount > MaxNumericDigits || digitCount < 1)
      throw RangeError.range(0, 1, MaxNumericDigits, "Digit Count");
    var digit = _random.nextInt(9) + 1; // first digit must not be a zero
    int n = digit;

    for (var i = 0; i < digitCount - 1; i++) {
      digit = _random.nextInt(10);
      n *= 10;
      n += digit;
    }
    return n;
  }

  static String getString(int digitCount) {
    String s = "";
    for (var i = 0; i < digitCount; i++) {
      s += _random.nextInt(10).toString();
    }
    return s;
  }
}
