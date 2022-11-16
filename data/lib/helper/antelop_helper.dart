import 'dart:convert';
import 'dart:math';

import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/apple_pay/enroll_card_request_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:domain/model/user/user.dart';
import 'package:eventify/eventify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<List<GetAllCardData>> listOfCardFromAntelop = BehaviorSubject.seeded([]);

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
          clientId = user.cifNumber ?? '';
          phoneNumber =
              "${(user.mobileCode ?? '').isNotEmpty ? (user.mobileCode!.contains('00') ? user.mobileCode!.replaceAll('00', '+') : '+') : ''}${user.mobile ?? ''}";
        }

        if (antelopWalletId.isEmpty) {
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

        // if (walletData["walletId"] != '') {
        //   _apiService
        //       .getEnrollCard(
        //     EnrollCardRequest(
        //         cardType: "C",
        //         //  cardId: "205897122871160",
        //         //  cardId: "205897122871140",
        //         cardId: "",
        //         walletId: walletData["walletId"].toString()),
        //   )
        //       .then((value) async {
        //     if (value.data.transform().status?.isSuccess ?? false) {
        //       debugPrint("Final enroll Card length " + value.data.content!.cards!.length.toString());
        //       debugPrint("Final  enroll Card ---> " + value.data.content!.cards![0].toString());
        //       value.data.content!.cards![0].enrollmentData!;
        //       var parameter = {"enrollmentData": value.data.content!.cards![0].enrollmentData!.toString()};
        //       var data = await platform.invokeMethod('enrollCard', parameter);
        //     } else {
        //       var cardsData = await platform.invokeMethod('getAllCards');
        //     }
        //   }, onError: (error) async {
        //     debugPrint("MainError ${error.toString()}");
        //     var cardsData = await platform.invokeMethod('getAllCards');
        //   });
        // } else {
        //   var cardsData = await platform.invokeMethod('getAllCards');
        // }
        _eventEmitter.emit(eventName, null, result);
        break;

      case "getCards":
        debugPrint("Flutter side getCards " + data.toString());
        dynamic newData = jsonDecode(data);

        if (newData != null) {
          print("print 1--> ");
          List<dynamic> newList = newData;
          print("print 2--> ");
          List<GetAllCardData> newDataList = [];
          print("print 3--> ");
          newDataList = newList.map((e) => GetAllCardData.fromJson(e)).toList();
          print("print 4--> ");
          print("newDataList getIssuerId 1--> " + newDataList.first.getIssuerCardId.toString());
          listOfCardFromAntelop.add(newDataList);

          List<GetAllCardData> antelopIssuerCardList = listOfCardFromAntelop.value;

          List<String> tempAntelopIssuerCardId = [];
          for (int i = 0; i < antelopIssuerCardList.length; i++) {
            tempAntelopIssuerCardId.add(antelopIssuerCardList[i].getIssuerCardId!);
          }

          List<String> unEnrolledDataList = [];
          BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

          _apiService.getAllCardList(BaseRequest(baseData: baseData.toJson())).then((value) {
            ///TODO:uncomment after wards
            // if (value.data.transform().status?.isSuccess ?? false) {
            //   for (int i = 0; i < value.data.content!.creditCardList!.length; i++) {
            //     if (!(tempAntelopIssuerCardId.contains(value.data.content!.creditCardList![i].cardId))) {
            //       unEnrolledDataList.add(value.data.content!.creditCardList![i].cardId ?? "");
            //     }
            //   }
            //
            //   for (int i = 0; i < value.data.content!.debitCardList!.length; i++) {
            //     if (!(tempAntelopIssuerCardId.contains(value.data.content!.debitCardList![i].cardId))) {
            //       unEnrolledDataList.add(value.data.content!.debitCardList![i].cardId ?? "");
            //     }
            //   }
            //   debugPrint("Antelop Wallet id ********** ${antelopWalletId} **********");
            //
            //   if (unEnrolledDataList.isNotEmpty) {
            //     _apiService
            //         .enrollCards(EnrollCardRequestEntity(
            //             baseData: baseData.toJson(),
            //             walletId: antelopWalletId,
            //             getToken: false,
            //             cardType: "C",
            //             cardId: ""))
            //         .then((value) async {
            //       if ((value.data.transform().enrollCardList ?? []).isNotEmpty) {
            //         ///getting list from api
            //         var cards = value.data.transform().enrollCardList;
            //
            //         ///map to send to native
            //         List<Map<String, dynamic>> params = [];
            //         for (int i = 0; i < (cards ?? []).length; i++) {
            //           for (int j = 0; j < unEnrolledDataList.length; j++) {
            //             if (unEnrolledDataList[j] == cards![i].cardId) {
            //               debugPrint("Particular Card Enroll Data ---> ${cards[i].cardId!} ---> " +
            //                   cards[i].enrollmentData.toString());
            //               params.add({
            //                 "cardId": cards[i].cardId,
            //                 "enrollmentData": cards[i].enrollmentData,
            //                 "isEnrolled": false
            //               });
            //               // var parameter = {
            //               //   "enrollmentData": value.data.content!.cards![i].enrollmentData!.toString()
            //               // };
            //             }
            //           }
            //         }
            //         var data = await platform.invokeMethod('enrollCard', params);
            //       } else {
            //         //  var cardsData = await platform.invokeMethod('getAllCards');
            //       }
            //     }, onError: (error) async {
            //       debugPrint("MainError ${error.toString()}");
            //       //  var cardsData = await platform.invokeMethod('getAllCards');
            //     });
            //   }
            // }
          });
        }
        break;

      case "emptyGetCards":
        debugPrint("Flutter side Empty Get Cards ");
        BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

        // ///Test purpose
        // _apiService.getAllCardList(BaseRequest(baseData: baseData.toJson()));

        ///Test purpose


        Future.delayed(Duration(seconds: 4), () {
          _apiService
              .enrollCards(EnrollCardRequestEntity(
                  baseData: baseData.toJson(),
                  walletId: antelopWalletId,
                  getToken: false,
                  cardType: "C",
                  cardId: ""))
              .then((value) async {
            if ((value.data.transform().enrollCardList ?? []).isNotEmpty) {
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
            debugPrint("MainError ${error.toString()}");
          });
        });

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
