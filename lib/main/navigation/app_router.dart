import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page.dart';
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
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page.dart';
import 'package:neo_bank/feature/static_content/exemption_from_fatca_reporting_code/exemption_from_fatca_reporting_code_page.dart';
import 'package:neo_bank/feature/static_content/fatca_certification/fatca_certification_page.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page.dart';
import 'package:neo_bank/feature/static_content/us_tax_payer_identification_number/us_tax_payer_identification_number_page.dart';
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
            builder: (context) => NotifySuccessPage(
                  notifySuccessArguments:
                      settings.arguments as NotifySuccessArguments,
                ),
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

      case RoutePaths.FatcaCertification:
        return CupertinoPageRoute(
            builder: (context) => FatcaCertificationPage(),
            settings: RouteSettings(name: RoutePaths.FatcaCertification));

      case RoutePaths.ExemptPayeeCode:
        return CupertinoPageRoute(
            builder: (context) => ExemptPayeeCodePage(),
            settings: RouteSettings(name: RoutePaths.ExemptPayeeCode));

      case RoutePaths.ExemptionFromFatcaReportingCode:
        return CupertinoPageRoute(
            builder: (context) => ExemptionFromFatcaReportingCodePage(),
            settings: RouteSettings(
                name: RoutePaths.ExemptionFromFatcaReportingCode));

      case RoutePaths.UsTaxPayerIdentificationNo:
        return CupertinoPageRoute(
            builder: (context) => UsTaxPayerIdentificationNumberPage(),
            settings:
                RouteSettings(name: RoutePaths.UsTaxPayerIdentificationNo));

      case RoutePaths.ReferenceNumber:
        return CupertinoPageRoute(
            builder: (context) => ReferenceNumberPage(),
            settings: RouteSettings(name: RoutePaths.ReferenceNumber));

      case RoutePaths.TaxTreatyBenefits:
        return CupertinoPageRoute(
            builder: (context) => ClaimOfTaxTreatyBenefitsPage(),
            settings: RouteSettings(name: RoutePaths.TaxTreatyBenefits));

      case RoutePaths.CardDelivery:
        return CupertinoPageRoute(
            builder: (context) => CardDeliveryPage(),
            settings: RouteSettings(name: RoutePaths.CardDelivery));

      case RoutePaths.CardReadySuccess:
        return CupertinoPageRoute(
            builder: (context) => CardReadySuccessPage(),
            settings: RouteSettings(name: RoutePaths.CardReadySuccess));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
