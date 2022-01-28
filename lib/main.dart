import 'dart:async';
import 'dart:io';

import 'package:data/network/utils/app_http_overrides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/main/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runZoned(() {
  //   HttpOverrides.global = AppHttpOverrides();
  //   runApp(ProviderScope(child: MyApp()));
  // });
  //runApp(ProviderScope(child: MyApp()));
  await runZonedGuarded(() async {
    HttpOverrides.global = AppHttpOverrides();
    await Firebase.initializeApp();

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    runApp(ProviderScope(child: MyApp()));
  }, (error, stackTrace) async {
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return App();
  }
}
