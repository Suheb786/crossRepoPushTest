import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/feature/splash/splash_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return CupertinoPageRoute(
            builder: (context) => SplashPage(),
            settings: RouteSettings(name: RoutePaths.Splash));

      case RoutePaths.Registration:
        return CupertinoPageRoute(
            builder: (context) => RegisterPage(),
            settings: RouteSettings(name: RoutePaths.Registration));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
