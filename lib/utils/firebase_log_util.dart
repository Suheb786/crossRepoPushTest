import 'package:firebase_analytics/firebase_analytics.dart';

class FireBaseLogUtil {
  FireBaseLogUtil._();

  static Future<void> fireBaseLog(String name, Map<String, dynamic> parameters) async {
    ///LOG EVENT TO FIREBASE

    parameters.updateAll((key, value) => value.toString());

    await FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }
}
