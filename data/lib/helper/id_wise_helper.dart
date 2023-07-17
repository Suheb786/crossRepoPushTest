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

  final journeyDefinitionId = "dbf6803b-6f9a-450d-9631-998b64fe871";

  void initializeIdWise() {
    platformChannel.invokeMethod('initialize', {"clientKey": clientId, "theme": "LIGHT"});
  }

  Future<Map<IDWiseStatus, String>> startVerification(String lang) async {
    Completer<Map<IDWiseStatus, String>> completer = Completer();
    platformChannel.setMethodCallHandler((handler) async {
      switch (handler.method) {
        case 'onJourneyStarted':
          print("Method: onJourneyStarted, ${handler.arguments.toString()}");
          break;
        case 'onJourneyFinished':
          print("Method: onJourneyFinished,${handler.arguments.toString()}");
          completer.complete({IDWiseStatus.COMPLETED: handler.arguments.toString()});
          break;

        case 'onJourneyCancelled':
          print("Method: onJourneyCancelled,${handler.arguments.toString()}");
          completer.complete({IDWiseStatus.CANCELLED: handler.arguments.toString()});
          break;

        case 'onJourneyResumed':
          print("Method: onJourneyResumed, ${handler.arguments.toString()}");
          break;

        case 'onError':
          print("Method: onError, ${handler.arguments.toString()}");
          completer.complete({IDWiseStatus.ERROR: handler.arguments.toString()});
          break;

        default:
          print('Unknown method from MethodChannel: ${handler.method}');
          completer.complete({IDWiseStatus.ERROR: handler.arguments.toString()});
          break;
      }
    });

    platformChannel.invokeMethod('startJourney', {
      "locale": lang,
      "referenceNo": "",
      "journeyDefinitionId": journeyDefinitionId,
    });

    // int statusCode = int.parse(journeyResult['statusCode'].toString());
    // debugPrint("CODE ----- ${statusCode.getIDWiseStatusFromCode().toString()}");
    // debugPrint("DATA ----- ${journeyResult['status']}");

    return completer.future;
  }

//  64476a7d6cc36a530ab19976
}

/*extension on int {
  IDWiseStatus getIDWiseStatusFromCode() {
    switch (this) {
      case 0:
        return IDWiseStatus.COMPLETED;
      case 1:
        return IDWiseStatus.CANCELLED;
      case 2:
        return IDWiseStatus.ERROR;
      case 3:
        return IDWiseStatus.STARTED;
      case 4:
        return IDWiseStatus.RESUMED;
      default:
        return IDWiseStatus.ERROR;
    }
  }
}*/
