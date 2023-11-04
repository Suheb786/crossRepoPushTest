import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:data/helper/key_helper.dart' as KeyHelper;

enum IDWiseStatus {
  COMPLETED,
  CANCELLED,
  ERROR,
  STARTED,
  RESUMED,
  ALREADY_STARTED,
}

class IdWiseHelper {
  static final IdWiseHelper _singleton = IdWiseHelper._internal();

  factory IdWiseHelper() {
    return _singleton;
  }

  IdWiseHelper._internal();

  static const methodChannelName = "com.codebaseneo.neo_bank/idwise";
  static const platformChannel = MethodChannel(methodChannelName);


  void initializeIdWise() {
    platformChannel.invokeMethod('initialize', {"clientKey": KeyHelper.KeyHelper.ID_Wise_Client_ID, "theme": "LIGHT"});
  }

  Future<Map<IDWiseStatus, String>> startVerification(String lang, String referenceNumber) async {
    Completer<Map<IDWiseStatus, String>> completer = Completer();

    platformChannel.setMethodCallHandler((handler) async {
      switch (handler.method) {
        case 'onJourneyStarted':
          debugPrint("Method: onJourneyStarted, Data: ${handler.arguments.toString()}");
          break;
        case 'onJourneyFinished':
          debugPrint("Method: onJourneyFinished, Data: ${handler.arguments.toString()}");
          completer.complete({IDWiseStatus.COMPLETED: handler.arguments.toString()});
          break;

        case 'onJourneyCancelled':
          debugPrint("Method: onJourneyCancelled, Data: ${handler.arguments.toString()}");
          completer.complete({IDWiseStatus.CANCELLED: handler.arguments.toString()});
          break;

        case 'onJourneyResumed':
          debugPrint("Method: onJourneyResumed, Data: ${handler.arguments.toString()}");
          break;

        case 'onError':
          debugPrint("Method: onError, Data: ${handler.arguments.toString()}");
          completer.complete({IDWiseStatus.ERROR: handler.arguments.toString()});
          break;

        default:
          debugPrint('Unknown method from MethodChannel: Data: ${handler.method}');
          completer.complete({IDWiseStatus.ERROR: handler.arguments.toString()});
          break;
      }
    });

    platformChannel.invokeMethod('startJourney', {
      "journeyDefinitionId": KeyHelper.KeyHelper.ID_Journey_Client_ID,
      "referenceNo": referenceNumber, //Put your reference number here
      "locale": lang
    });

    return completer.future;
  }
}


/// TO USE THIS LIBRARY
///
/// IdWiseHelper idWiseHelper = IdWiseHelper();
/// idWiseHelper.initializeIdWise();
/// var status = await idWiseHelper.startVerification('en');
/// debugPrint("STATUS : ${status.keys.first}");
/// debugPrint("TEXT :  ${status.values.first}");