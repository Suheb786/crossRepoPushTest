import 'dart:convert';
import 'dart:math';

import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/apple_pay/enroll_card_request_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:domain/constants/app_constants.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:domain/model/user/user.dart';
import 'package:eventify/eventify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<List<GetAllCardData>> listOfCardFromAntelop = BehaviorSubject.seeded([]);

BehaviorSubject<bool> antelopStepCompleted = BehaviorSubject.seeded(true);

Stream<bool> get antelopStepCompletedStream => antelopStepCompleted.stream;

BehaviorSubject<bool> pushCardError = BehaviorSubject.seeded(false);

Stream<bool> get pushCardErrorStream => pushCardError.stream;

BehaviorSubject<bool> pushCardSuccess = BehaviorSubject.seeded(false);

Stream<bool> get pushCardSuccessStream => pushCardSuccess.stream;

bool isAllCardsInApplePay = true;

class AntelopHelper {
  static const platform = const MethodChannel('com.capital.cbt');
  String result = '';
  bool showText = false;

  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;
  EventChannel eventChannel = EventChannel("continueListining");
  final EventEmitter _eventEmitter = EventEmitter();
  String antelopWalletId = '';
  static String constantAuthToken = "";
  bool onProvisioningError = true;

  AntelopHelper(this._apiService, this._deviceInfoHelper) {
    registerAntelopEvents();
    registerSdkCalback();
    getWalletId();
  }

  getWalletId() async {
    var id = await SecureStorageHelper.instance.getWalletId();
    if ((id ?? '').isNotEmpty) {
      debugPrint('Wallet Id from secure Storage---->$id');
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

  static Future<void> walletLogout() async {
    try {
      debugPrint("wallet logout");
      var data = await platform.invokeMethod('walletLogout');
    } on PlatformException catch (e) {}
  }

  Future<bool> onInitializationFromNative() async {
    try {
      getWalletId();
      var data = await platform.invokeMethod('initialize');
      return true;
    } on PlatformException catch (e) {
      debugPrint('Failed to get version: ${e.message}');
      return false;
    }
  }

  Future<bool> getAntelopCardList() async {
    try {
      var data = await platform.invokeMethod('getAntelopCards');
      return true;
    } on PlatformException catch (e) {
      debugPrint('Failed : ${e.message}');
      return false;
    }
  }

  Future<bool> pushCardToApplePay(String cardId) async {
    var parameter = {
      "cardId": cardId,
    };
    try {
      var data = await platform.invokeMethod('pushCard', parameter);
      return true;
    } on PlatformException catch (e) {
      debugPrint('Failed : ${e.message}');
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
          clientId = user.cifNumber ?? '';
          phoneNumber =
              "${(user.mobileCode ?? '').isNotEmpty ? (user.mobileCode!.contains('00') ? user.mobileCode!.replaceAll('00', '+') : '+') : ''}${user.mobile ?? ''}";
        }

        if (antelopWalletId == '' || antelopWalletId.isEmpty) {
          String randomWalletId = RandomDigits.getInteger(16).toString();
          debugPrint("randomWalletId----> $randomWalletId");
          var parameter = {
            "clientId": clientId,
            "walletId": randomWalletId,
            "settingsProfileId": "blink",
            //"phoneNumber": "+962123456789",
            "phoneNumber": phoneNumber
          };
          debugPrint("on device eligible parameter--->${parameter.toString()}");
          var launchData = await platform.invokeMethod('getWalletLaunch', parameter);
        } else {
          debugPrint('Wallet Id not empty');
          debugPrint('Wallet Id ---->$antelopWalletId');
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

      case "onProvisioningError":
        Map newData = jsonDecode(data);
        debugPrint("Flutter onProvisioningError " + newData.toString());

        if (onProvisioningError) {
          String clientId = '';
          String phoneNumber = '';
          User? user = await SecureStorageHelper.instance.getUserDataFromSecureStorage();
          if (user != null) {
            clientId = user.cifNumber ?? '';
            phoneNumber =
                "${(user.mobileCode ?? '').isNotEmpty ? (user.mobileCode!.contains('00') ? user.mobileCode!.replaceAll('00', '+') : '+') : ''}${user.mobile ?? ''}";
          }
          String randomWalletId = RandomDigits.getInteger(16).toString();
          debugPrint("randomWalletId in onProvisioningError----> $randomWalletId");
          onProvisioningError = false;
          var parameter = {
            "clientId": clientId,
            "walletId": randomWalletId,
            "settingsProfileId": "blink",
            "phoneNumber": phoneNumber
          };
          debugPrint("parameter in onProvisioningError----> ${parameter.toString()}");
          var launchData = await platform.invokeMethod('getWalletLaunch', parameter);
        }
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

        /// TODO getCards from Antelop and call API

        var cardsData = await platform.invokeMethod('getAllCards');
        _eventEmitter.emit(eventName, null, result);
        break;

      case "getCards":
        debugPrint("Flutter side getCards " + data.toString());
        dynamic newData = jsonDecode(data);

        if (newData != null) {
          List<dynamic> newList = newData;
          List<GetAllCardData> newDataList = [];
          newDataList = newList.map((e) => GetAllCardData.fromJson(e)).toList();
          listOfCardFromAntelop.add(newDataList);

          if (newDataList.isNotEmpty) {
            var isAllCardInApplePay = newDataList.any((element) => !(element.isCardInApplePay ?? false));
            isAllCardsInApplePay = isAllCardInApplePay;
            debugPrint('Is all card in apple pay=======>$isAllCardInApplePay');

            antelopStepCompleted.add(false);
          }

          List<GetAllCardData> antelopIssuerCardList = listOfCardFromAntelop.value;

          List<String> tempAntelopIssuerCardId = [];
          for (int i = 0; i < antelopIssuerCardList.length; i++) {
            tempAntelopIssuerCardId.add(antelopIssuerCardList[i].getIssuerCardId!.trim());
          }

          debugPrint('TempAntelopIssuerCardId ---->${tempAntelopIssuerCardId}');

          List<String> unEnrolledDataList = [];
          BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

          _apiService.getAllCardList(BaseRequest(getToken: false, baseData: baseData.toJson())).then((value) {
            if (value.data.transform().dashboardDataContent != null) {
              var dashBoardData = value.data.transform().dashboardDataContent;
              for (int i = 0; i < (dashBoardData?.creditCard ?? []).length; i++) {
                debugPrint('Credit Card Code from list  ---->${dashBoardData!.creditCard![i].cardCode}');
                if (!(tempAntelopIssuerCardId.contains(dashBoardData.creditCard![i].cardCode!.trim()))) {
                  unEnrolledDataList.add((dashBoardData.creditCard![i].cardCode ?? "").trim());
                }
              }

              for (int i = 0; i < (dashBoardData?.debitCard ?? []).length; i++) {
                debugPrint('Debit Card Code from list  ---->${dashBoardData!.debitCard![i].cardCode}');
                if (!(tempAntelopIssuerCardId.contains(dashBoardData.debitCard![i].cardCode!.trim()))) {
                  unEnrolledDataList.add((dashBoardData.debitCard![i].cardCode ?? "").trim());
                }
              }

              debugPrint("Antelop Wallet id *********** ${antelopWalletId} ***********");

              if (unEnrolledDataList.isNotEmpty) {
                debugPrint('UnEnrolledCardList ---->${unEnrolledDataList}');
                AppConstants.IS_BACKGROUND_API_IN_PROGRESS = true;

                _apiService
                    .enrollCards(EnrollCardRequestEntity(
                        baseData: baseData.toJson(),
                        walletId: antelopWalletId,
                        getToken: false,
                        cardType: "",
                        cardId: ""))
                    .then((value) async {
                  if ((value.data.transform().enrollCardList ?? []).isNotEmpty) {
                    AppConstants.IS_BACKGROUND_API_IN_PROGRESS = false;

                    ///getting list from api
                    var cards = value.data.transform().enrollCardList;
                    List<Map<String, dynamic>> params = [];
                    for (int i = 0; i < (cards ?? []).length; i++) {
                      for (int j = 0; j < unEnrolledDataList.length; j++) {
                        if (unEnrolledDataList[j] == cards![i].cardId!.trim()) {
                          debugPrint("Particular Card Enroll Data ---> ${cards[i].cardId} ---> " +
                              cards[i].enrollmentData.toString());
                          params.add({
                            "cardId": cards[i].cardId,
                            "enrollmentData": cards[i].enrollmentData,
                            "isEnrolled": false
                          });
                        }
                      }
                    }
                    var data = await platform.invokeMethod('enrollCard', params);
                  }
                }, onError: (error) async {
                  AppConstants.IS_BACKGROUND_API_IN_PROGRESS = false;
                  debugPrint("MainError------> ${error.toString()}");
                });
              }
            }
          });
        }
        break;

      case "emptyGetCards":
        debugPrint("Flutter side Empty Get Cards ");
        AppConstants.IS_BACKGROUND_API_IN_PROGRESS = true;
        BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

        isAllCardsInApplePay = true;

        // ///Test purpose
        // _apiService.getAllCardList(BaseRequest(baseData: baseData.toJson()));

        ///Test purpose

        _apiService
            .enrollCards(EnrollCardRequestEntity(
                baseData: baseData.toJson(),
                walletId: antelopWalletId,
                getToken: false,
                cardType: "",
                cardId: ""))
            .then((value) async {
          if ((value.data.transform().enrollCardList ?? []).isNotEmpty) {
            AppConstants.IS_BACKGROUND_API_IN_PROGRESS = false;

            ///getting list from api
            var cards = value.data.transform().enrollCardList;
            List<Map<String, dynamic>> params = [];
            for (int i = 0; i < cards!.length; i++) {
              debugPrint("enroll card api response data card id ********** ${cards[i].cardId} **********");
              debugPrint(
                  "enroll card api response data enrollment data ********** ${cards[i].enrollmentData} **********");
              //   var parameter = {"enrollmentData": value.data.content!.cards![i].enrollmentData!.toString()};
              params.add({
                "cardId": cards[i].cardId,
                "enrollmentData": cards[i].enrollmentData,
                "isEnrolled": false
              });
            }
            var data = await platform.invokeMethod('enrollCard', params);
          }
        }, onError: (error) async {
          AppConstants.IS_BACKGROUND_API_IN_PROGRESS = false;
          debugPrint("MainError------> ${error.toString()}");
        });

        break;

      case "enrollCardSuccess":
        debugPrint("Flutter side enrollCardSuccess " + data.toString());
        var cardsData = await platform.invokeMethod('getAllCards');
        break;

      case "enrollCardError":
        debugPrint("Flutter side enrollCardError " + data.toString());
        break;

      case "enrollCardCatch":
        debugPrint("Flutter side enrollCardCatch " + data.toString());
        break;

      case "pushCardSuccess":
        debugPrint("Flutter side push card success " + data.toString());
        pushCardSuccess.add(true);
        break;

      case "pushCardError":
        debugPrint("Flutter side push card error " + data.toString());
        pushCardError.add(true);
        break;

      case "antelopCardsList":
        debugPrint("Flutter side antelopCards " + data.toString());
        dynamic newData = jsonDecode(data);

        if (newData != null) {
          List<dynamic> newList = newData;
          List<GetAllCardData> newDataList = [];
          newDataList = newList.map((e) => GetAllCardData.fromJson(e)).toList();
          listOfCardFromAntelop.add(newDataList);

          ///check whether all card in apple pay
          var isAllCardInApplePay = newDataList.any((element) => !(element.isCardInApplePay ?? false));

          debugPrint('Is all card in apple pay=======>$isAllCardInApplePay');
          isAllCardsInApplePay = isAllCardInApplePay;
          antelopStepCompleted.add(false);
        }
        break;

      case "antelopEmptyCardsList":
        debugPrint("Flutter side antelopEmptyCardsList " + data.toString());
        List<GetAllCardData> newDataList = [];
        listOfCardFromAntelop.add(newDataList);
        if (newDataList.isEmpty) {
          isAllCardsInApplePay = true;
          antelopStepCompleted.add(false);
        }
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
