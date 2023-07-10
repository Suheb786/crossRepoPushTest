import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum IDWiseStatus {
  COMPLETED,
  CANCELLED,
  ERROR,
  STARTED,
  RESUMED,
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
    platformChannel.invokeMethod('initialize', {"clientID": clientId, "theme": ""});
  }

  Future<IDWiseStatus> startVerification(String lang) async {
    var journeyResult = await platformChannel.invokeMethod('startJourney', {
      "lang": lang,
      "referenceNo": "",
      "journeyDefinitionId": journeyDefinitionId,
    });

    int statusCode = int.parse(journeyResult['statusCode'].toString());
    debugPrint("CODE ----- ${statusCode.getIDWiseStatusFromCode().toString()}");
    debugPrint("DATA ----- ${journeyResult['status']}");

    return statusCode.getIDWiseStatusFromCode();
  }

//  64476a7d6cc36a530ab19976
}

extension on int {
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
}
