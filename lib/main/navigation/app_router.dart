import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page.dart';
import 'package:neo_bank/feature/login/login_page.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_page.dart';
import 'package:neo_bank/feature/splash/splash_page.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return CupertinoPageRoute(
            builder: (context) => SplashPage(),
            settings: RouteSettings(name: RoutePaths.Splash));

      case RoutePaths.Login:
        return CupertinoPageRoute(
            builder: (context) => LoginPage(),
            settings: RouteSettings(name: RoutePaths.Login));

      case RoutePaths.OnBoarding:
        return CupertinoPageRoute(
            builder: (context) => OnBoardingPage(),
            settings: RouteSettings(name: RoutePaths.OnBoarding));

      case RoutePaths.Registration:
        return CupertinoPageRoute(
            builder: (context) => RegisterPage(),
            settings: RouteSettings(name: RoutePaths.Registration));

      case RoutePaths.AccountReady:
        return CupertinoPageRoute(
            builder: (context) => AccountReadyPage(),
            settings: RouteSettings(name: RoutePaths.AccountReady));

      case RoutePaths.NotifySuccess:
        return CupertinoPageRoute(
            builder: (context) => NotifySuccessPage(),
            settings: RouteSettings(name: RoutePaths.NotifySuccess));

      case RoutePaths.AccountRegistration:
        return CupertinoPageRoute(
            builder: (context) => AccountRegistrationPage(),
            settings: RouteSettings(name: RoutePaths.AccountRegistration));

      case RoutePaths.ProductSelector:
        return CupertinoPageRoute(
            builder: (context) => ProductSelectorPage(),
            settings: RouteSettings(name: RoutePaths.ProductSelector));

      case RoutePaths.NonJordanianRegister:
        return CupertinoPageRoute(
            builder: (context) => NonJordanianRegistrationPage(),
            settings: RouteSettings(name: RoutePaths.NonJordanianRegister));

      case RoutePaths.Dashboard:
        return CupertinoPageRoute(
            builder: (context) => DashboardPage(),
            settings: RouteSettings(name: RoutePaths.Dashboard));

      case RoutePaths.TermsAndCondition:
        return CupertinoPageRoute(
            builder: (context) => TermsAndConditionPage(),
            settings: RouteSettings(name: RoutePaths.TermsAndCondition));

      case RoutePaths.Capture:
        return CupertinoPageRoute(
            builder: (context) => CapturePage(),
            settings: RouteSettings(name: RoutePaths.Capture));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
