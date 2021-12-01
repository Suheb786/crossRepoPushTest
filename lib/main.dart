import 'dart:async';
import 'dart:io';

import 'package:data/network/utils/app_http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/main/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(() {
    HttpOverrides.global = AppHttpOverrides();
    runApp(ProviderScope(child: MyApp()));
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
