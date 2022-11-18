import 'dart:async';
import 'dart:io';

import 'package:data/network/utils/app_http_overrides.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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
  await runZonedGuarded(() async {
    HttpOverrides.global = AppHttpOverrides();
    await Firebase.initializeApp();

    //await FirebaseAnalytics.instance.logEvent(name: "Test");

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.setCurrentScreen(screenName: "Main Screen");
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
      },
    );

    runApp(ProviderScope(
      child: DevicePreview(
        enabled: true,
        builder: (context) => MyApp(),
      ),
    ));
  }, (error, stackTrace) async {
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      fatal: true,
      reason: 'a fatal error',
      printDetails: true,
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

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

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   print('inside----> lifecycle state');
//   print('inside----> lifecycle state-->$state');
//   if (state == AppLifecycleState.resumed) {
//     print('inside----> lifecycle resumed');
//     if (ProviderScope.containerOf(context).read(appViewModel) != null) {
//       ProviderScope.containerOf(context)
//           .read(appViewModel)
//           .resumeRefreshToken();
//     }
//   }
//   if (state == AppLifecycleState.inactive) {
//     print('inside----> lifecycle inactive');
//     if (ProviderScope.containerOf(context).read(appViewModel) != null) {
//       ProviderScope.containerOf(context)
//           .read(appViewModel)
//           .pauseRefreshToken();
//     }
//   }
//
//   if (state == AppLifecycleState.paused) {
//     print('inside----> lifecycle paused');
//     if (ProviderScope.containerOf(context).read(appViewModel) != null) {
//       ProviderScope.containerOf(context)
//           .read(appViewModel)
//           .stopRefreshToken();
//     }
//   }
//   super.didChangeAppLifecycleState(state);
// }
}
