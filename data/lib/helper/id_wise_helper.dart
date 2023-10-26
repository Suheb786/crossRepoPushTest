import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final clientId =
      "QmFzaWMgWkdKbU5qZ3dNMkl0Tm1ZNVlTMDBOVEJrTFRrMk16RXRPVGs0WWpZMFptVTROekZpT2t4Sk4xTjNPR3hoUm5wNGFqUk5NbWRZVVVSek1rNWFhRlJDU0dObU9XTlhTakIwZGpaWlVWVT0=";

  final journeyDefinitionId = "dbf6803b-6f9a-450d-9631-998b64fe871b";

  void initializeIdWise() {
    platformChannel.invokeMethod('initialize', {"clientKey": clientId, "theme": "LIGHT"});
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
      "journeyDefinitionId": journeyDefinitionId,
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