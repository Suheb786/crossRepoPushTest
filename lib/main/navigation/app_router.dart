import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/change_email_address_page.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/change_mobile_number_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/change_password_page.dart';
import 'package:neo_bank/feature/account_settings/my_documents/my_documents_page.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_page.dart';
import 'package:neo_bank/feature/apply_credit_card_home/apply_credit_card_home_page.dart';
import 'package:neo_bank/feature/blink_credit_card/blink_credit_card_page.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page.dart';
import 'package:neo_bank/feature/help_center/help_center_page.dart';
import 'package:neo_bank/feature/login/login_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_debit_card_limits_page.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_page.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_page.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_page.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_page.dart';
import 'package:neo_bank/feature/payment/request_money_failure/request_money_failure_page.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_page.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_page.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_page.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_page.dart';
import 'package:neo_bank/feature/payment/send_money/send_money_page.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_page.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_page.dart';
import 'package:neo_bank/feature/splash/splash_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page.dart';
import 'package:neo_bank/feature/static_content/exemption_from_fatca_reporting_code/exemption_from_fatca_reporting_code_page.dart';
import 'package:neo_bank/feature/static_content/fatca_certification/fatca_certification_page.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page.dart';
import 'package:neo_bank/feature/static_content/us_tax_payer_identification_number/us_tax_payer_identification_number_page.dart';
import 'package:neo_bank/feature/supplementary_card_in_review/supplementary_card_in_review_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card/supplementary_credit_card_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_ready/supplementary_credit_card_ready_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card/supplementary_debit_card_page.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
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

      case RoutePaths.AddMoneyOptionSelector:
        // return CupertinoPageRoute(
        //     builder: (context) => AddMoneyOptionSelectorPage(),
        //     settings: RouteSettings(name: RoutePaths.AddMoneyOptionSelector));
        return CustomRoute.createRoute(AddMoneyOptionSelectorPage(),
            reverse: true);

      case RoutePaths.LocateATM:
        return CupertinoPageRoute(
            builder: (context) => LocateATMPage(),
            settings: RouteSettings(name: RoutePaths.LocateATM));

      case RoutePaths.AppHome:
        return CupertinoPageRoute(
            builder: (context) => AppHomePage(),
            settings: RouteSettings(name: RoutePaths.AppHome));

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

      case RoutePaths.ChangeEmailAddress:
        return CupertinoPageRoute(
            builder: (context) => ChangeEmailAddressPage(),
            settings: RouteSettings(name: RoutePaths.ChangeEmailAddress));

      case RoutePaths.AccountSetting:
        return CupertinoPageRoute(
            builder: (context) => AccountSettingPage(),
            settings: RouteSettings(name: RoutePaths.AccountSetting));

      case RoutePaths.ChangeMobileNumber:
        return CupertinoPageRoute(
            builder: (context) => ChangeMobileNumberPage(),
            settings: RouteSettings(name: RoutePaths.ChangeMobileNumber));

      case RoutePaths.ChangePassword:
        return CupertinoPageRoute(
            builder: (context) => ChangePasswordPage(),
            settings: RouteSettings(name: RoutePaths.ChangePassword));

      case RoutePaths.MyDocuments:
        return CupertinoPageRoute(
            builder: (context) => MyDocumentsPage(),
            settings: RouteSettings(name: RoutePaths.MyDocuments));

      case RoutePaths.ManageContactsList:
        return CupertinoPageRoute(
            builder: (context) => ManageContactListPage(),
            settings: RouteSettings(name: RoutePaths.ManageContactsList));

      case RoutePaths.ManageContactsDetail:
        return CupertinoPageRoute(
            builder: (context) =>
                ManageContactDetailsPage(settings.arguments as Beneficiary),
            settings: RouteSettings(name: RoutePaths.ManageContactsDetail));

      case RoutePaths.DownloadTransaction:
        return CupertinoPageRoute(
            builder: (context) => DownloadTransactionPage(
                settings.arguments as DownloadStatementArguments),
            settings: RouteSettings(name: RoutePaths.DownloadTransaction));

      case RoutePaths.CardTransaction:
        return CustomRoute.createRoute(CardTransactionPage());

      case RoutePaths.AccountTransaction:
        return CustomRoute.createRoute(AccountTransactionPage());

      case RoutePaths.CreditCardDelivered:
        return CupertinoPageRoute(
            builder: (context) => CreditCardDeliveredPage(
                creditCard: settings.arguments as CreditCard),
            settings: RouteSettings(name: RoutePaths.CreditCardDelivered));

      case RoutePaths.DebitCardDelivered:
        return CupertinoPageRoute(
            builder: (context) => DebitCardDeliveredPage(
                debitCard: settings.arguments as DebitCard),
            settings: RouteSettings(name: RoutePaths.DebitCardDelivered));

      case RoutePaths.CreditCardVerificationSuccess:
        return CupertinoPageRoute(
            builder: (context) => CreditCardVerificationSuccessPage(),
            settings:
                RouteSettings(name: RoutePaths.CreditCardVerificationSuccess));

      case RoutePaths.DebitCardVerificationSuccess:
        return CupertinoPageRoute(
            builder: (context) => DebitCardVerificationSuccessPage(),
            settings:
                RouteSettings(name: RoutePaths.DebitCardVerificationSuccess));

      case RoutePaths.PaymentHome:
        return CustomRoute.createRoute(PaymentHomePage());

      case RoutePaths.ActivityHome:
        return CupertinoPageRoute(
            builder: (context) => ActivityHomePage(),
            settings: RouteSettings(name: RoutePaths.ActivityHome));

      case RoutePaths.RequestMoneyFailure:
        return CupertinoPageRoute(
            builder: (context) => RequestMoneyFailurePage(),
            settings: RouteSettings(name: RoutePaths.RequestMoneyFailure));

      case RoutePaths.SendMoneyFailure:
        return CupertinoPageRoute(
            builder: (context) => SendMoneyFailurePage(),
            settings: RouteSettings(name: RoutePaths.SendMoneyFailure));

      case RoutePaths.RequestAmountFromContact:
        return CustomRoute.createRoute(RequestAmountFromContactPage(
            beneficiary: settings.arguments as Beneficiary));

      case RoutePaths.SendAmountToContact:
        return CustomRoute.createRoute(
            SendAmountToContactPage(settings.arguments as Beneficiary));

      case RoutePaths.SendAmountToContactSuccess:
        return CupertinoPageRoute(
            builder: (context) => SendAmountToContactSuccessPage(
                  arguments: settings.arguments as TransferSuccessContent,
                ),
            settings:
                RouteSettings(name: RoutePaths.SendAmountToContactSuccess));

      case RoutePaths.SendMoney:
        return CustomRoute.createRoute(SendMoneyPage());

      case RoutePaths.RequestMoney:
        return CustomRoute.createRoute(RequestMoneyPage());

      case RoutePaths.RequestAmountFromContactSuccess:
        return CupertinoPageRoute(
            builder: (context) => RequestAmountFromContactSuccessPage(
                  successValues: settings.arguments as List<String>,
                ),
            settings: RouteSettings(
                name: RoutePaths.RequestAmountFromContactSuccess));

      case RoutePaths.RequestPaymentFromNewRecipient:
        return CupertinoPageRoute(
            builder: (context) => RequestPaymentFromNewRecipientPage(
                requestValue: settings.arguments as String),
            settings:
                RouteSettings(name: RoutePaths.RequestPaymentFromNewRecipient));

      case RoutePaths.PaymentToNewRecipient:
        return CupertinoPageRoute(
            builder: (context) => PaymentToNewRecipientPage(
                sendValue: settings.arguments as String),
            settings: RouteSettings(name: RoutePaths.PaymentToNewRecipient));

      case RoutePaths.DebitCardSettings:
        return CustomRoute.createRoute(DebitCardSettingsPage());
      case RoutePaths.CreditCardSettings:
        return CupertinoPageRoute(
            builder: (context) => CreditCardSettingsPage(),
            settings: RouteSettings(name: RoutePaths.CreditCardSettings));

      case RoutePaths.HelpCenter:
        return CupertinoPageRoute(
            builder: (context) => HelpCenterPage(),
            settings: RouteSettings(name: RoutePaths.HelpCenter));

      case RoutePaths.ActiveCallPage:
        return CupertinoPageRoute(
            builder: (context) => ActiveCallPage(),
            settings: RouteSettings(name: RoutePaths.ActiveCallPage));

      case RoutePaths.CallEndedPage:
        return CupertinoPageRoute(
            builder: (context) => CallEndedPage(),
            settings: RouteSettings(name: RoutePaths.CallEndedPage));

      case RoutePaths.ManageCardPin:
        return CustomRoute.createRoute(
          ManageCardPinPage(
              manageCardPinArguments:
                  settings.arguments as ManageCardPinArguments),
        );

      case RoutePaths.CardPinUnBlockSuccess:
        return CupertinoPageRoute(
            builder: (context) => CardPinUnBlockSuccessPage(
                manageCardPinArguments:
                    settings.arguments as ManageCardPinArguments),
            settings: RouteSettings(name: RoutePaths.CardPinUnBlockSuccess));

      case RoutePaths.DebitCardReplacement:
        return CupertinoPageRoute(
            builder: (context) => DebitCardReplacementPage(),
            settings: RouteSettings(name: RoutePaths.DebitCardReplacement));

      case RoutePaths.DebitCardReplacementSuccess:
        return CupertinoPageRoute(
            builder: (context) => DebitCardReplacementSuccessPage(),
            settings:
                RouteSettings(name: RoutePaths.DebitCardReplacementSuccess));

      case RoutePaths.manageDebitLimit:
        return CustomRoute.createRoute(ManageDebitCardLimitsPage(
            settings.arguments as ManageCardLimitsArguments));

      case RoutePaths.ChangeCardPin:
        return CupertinoPageRoute(
            builder: (context) => ChangeCardPinPage(),
            settings: RouteSettings(name: RoutePaths.ChangeCardPin));

      case RoutePaths.ChangeCardPinSuccess:
        return CupertinoPageRoute(
            builder: (context) => ChangeCardPinSuccessPage(
                settings.arguments as ChangeCardPinSuccessArguments),
            settings: RouteSettings(name: RoutePaths.ChangeCardPinSuccess));

      case RoutePaths.SupplementaryCreditCard:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryCreditCardPage(),
            settings: RouteSettings(name: RoutePaths.SupplementaryCreditCard));

      case RoutePaths.SupplementaryCreditCardReady:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryCreditCardReadyPage(),
            settings:
                RouteSettings(name: RoutePaths.SupplementaryCreditCardReady));

      case RoutePaths.SupplementaryDebitCard:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryDebitCardPage(),
            settings: RouteSettings(name: RoutePaths.SupplementaryDebitCard));

      case RoutePaths.SupplementaryCardInReview:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryCardInReviewPage(
                settings.arguments as SupplementaryCardInReviewArguments),
            settings:
                RouteSettings(name: RoutePaths.SupplementaryCardInReview));

      case RoutePaths.BlinkCreditCard:
        return CustomRoute.createRoute(BlinkCreditCardPage());

      case RoutePaths.CreditCardApplicationFailure:
        return CupertinoPageRoute(
            builder: (context) => CreditCardApplicationFailurePage(),
            settings:
                RouteSettings(name: RoutePaths.CreditCardApplicationFailure));

      case RoutePaths.ApplyCreditCardHome:
        return CupertinoPageRoute(
            builder: (context) => ApplyCreditCardHomePage(),
            settings: RouteSettings(name: RoutePaths.ApplyCreditCardHome));

      case RoutePaths.AccountHold:
        return CupertinoPageRoute(
            builder: (context) => AccountHoldPage(),
            settings: RouteSettings(name: RoutePaths.AccountHold));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
