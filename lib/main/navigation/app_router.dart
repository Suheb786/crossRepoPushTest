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
import 'package:neo_bank/feature/change_country_restriction/change_country_restriction_page.dart';
import 'package:neo_bank/feature/change_credit_limit/change_credit_limit_page.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page.dart';
import 'package:neo_bank/feature/change_device_flow/otp_for_change_device/otp_for_change_device_confirmation_page.dart';
import 'package:neo_bank/feature/covert_purchase_to_installements/covert_purchase_to_installments_page.dart';
import 'package:neo_bank/feature/credit_card_activation_status/credit_card_activation_status_page.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page.dart';
import 'package:neo_bank/feature/credit_card_pay_back_success/credit_card_pay_back_success_page.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_page.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_complete/credit_card_videocall_complete_page.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page.dart';
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
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_page.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_delivery_page.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_ready/dc_setting_card_ready_page.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page.dart';
import 'package:neo_bank/feature/evoucher/e_voucher_main_page.dart';
import 'package:neo_bank/feature/evoucher/enter_code_evoucher_puchase/enter_code_evoucher_puchase_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher_detail/evoucher_detail_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page.dart';
import 'package:neo_bank/feature/forgot_password/forgot_password_page.dart';
import 'package:neo_bank/feature/forgot_password/reset_password_success/reset_password_success_page.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page.dart';
import 'package:neo_bank/feature/help_center/help_center_page.dart';
import 'package:neo_bank/feature/login/login_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/create_cliq_id_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/edit_mobile_no_cliq_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_payment_account/change_card_payment_account_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/manage_credit_settlement_page.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_debit_card_limits_page.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page.dart';
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
import 'package:neo_bank/feature/postpaid_bills/launcher_page.dart';
import 'package:neo_bank/feature/postpaid_bills/new_bill/new_bills_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pall_all_postpaid_bills_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/confirm_bill_payment_amount/confirm_bill_payment_amount_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_detail/pay_bill_detail_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/step_five/video_call_scheduled/video_call_scheduled_page.dart';
import 'package:neo_bank/feature/register/stepone/capture/capture_page.dart';
import 'package:neo_bank/feature/register/upload_document_later/upload_document_later_page.dart';
import 'package:neo_bank/feature/register/video_call/video_call_page.dart';
import 'package:neo_bank/feature/renew_credit_card/renew_credit_card_page.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/qr_scanning_screen/qr_scanning_screen_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page.dart';
import 'package:neo_bank/feature/splash/splash_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page.dart';
import 'package:neo_bank/feature/static_content/exemption_from_fatca_reporting_code/exemption_from_fatca_reporting_code_page.dart';
import 'package:neo_bank/feature/static_content/fatca_certification/fatca_certification_page.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page.dart';
import 'package:neo_bank/feature/static_content/us_tax_payer_identification_number/us_tax_payer_identification_number_page.dart';
import 'package:neo_bank/feature/supplementary_card_in_review/supplementary_card_in_review_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card/supplementary_credit_card_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_ready/supplementary_credit_card_ready_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card/supplementary_debit_card_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/supplementary_debit_card_pin_set_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card_success/supplementary_debit_card_success_page.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_page.dart';
import 'package:neo_bank/feature/view_debit_card_subscription/view_debit_card_subscription_page.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/navgition_type.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return CupertinoPageRoute(
            builder: (context) => SplashPage(), settings: RouteSettings(name: RoutePaths.Splash));

      case RoutePaths.Login:
        return CupertinoPageRoute(
            builder: (context) => LoginPage(), settings: RouteSettings(name: RoutePaths.Login));

      case RoutePaths.OnBoarding:
        return CupertinoPageRoute(
            builder: (context) => OnBoardingPage(), settings: RouteSettings(name: RoutePaths.OnBoarding));

      case RoutePaths.Registration:
        return CupertinoPageRoute(
            builder: (context) => RegisterPage(settings.arguments as RegisterPageParams),
            settings: RouteSettings(name: RoutePaths.Registration));

      case RoutePaths.AccountReady:
        return CupertinoPageRoute(
            builder: (context) => AccountReadyPage(settings.arguments as AccountReadyArguments),
            settings: RouteSettings(name: RoutePaths.AccountReady));

      case RoutePaths.NotifySuccess:
        return CupertinoPageRoute(
            builder: (context) => NotifySuccessPage(
                  notifySuccessArguments: settings.arguments as NotifySuccessArguments,
                ),
            settings: RouteSettings(name: RoutePaths.NotifySuccess));

      case RoutePaths.AccountRegistration:
        return CupertinoPageRoute(
            builder: (context) => AccountRegistrationPage(settings.arguments as AccountRegistrationParams),
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
            builder: (context) => DashboardPage(), settings: RouteSettings(name: RoutePaths.Dashboard));

      case RoutePaths.TermsAndCondition:
        return CupertinoPageRoute(
            builder: (context) => TermsAndConditionPage(),
            settings: RouteSettings(name: RoutePaths.TermsAndCondition));

      case RoutePaths.AddMoneyOptionSelector:
        // return CupertinoPageRoute(
        //     builder: (context) => AddMoneyOptionSelectorPage(),
        //     settings: RouteSettings(name: RoutePaths.AddMoneyOptionSelector));
        return CustomRoute.createRoute(AddMoneyOptionSelectorPage(), reverse: true);

      case RoutePaths.LocateATM:
        return CupertinoPageRoute(
            builder: (context) => LocateATMPage(), settings: RouteSettings(name: RoutePaths.LocateATM));

      case RoutePaths.AppHome:
        return CupertinoPageRoute(
            builder: (context) => AppHomePage(), settings: RouteSettings(name: RoutePaths.AppHome));

      case RoutePaths.Capture:
        return CupertinoPageRoute(
            builder: (context) => CapturePage(), settings: RouteSettings(name: RoutePaths.Capture));

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
            settings: RouteSettings(name: RoutePaths.ExemptionFromFatcaReportingCode));

      case RoutePaths.UsTaxPayerIdentificationNo:
        return CupertinoPageRoute(
            builder: (context) => UsTaxPayerIdentificationNumberPage(),
            settings: RouteSettings(name: RoutePaths.UsTaxPayerIdentificationNo));

      case RoutePaths.ReferenceNumber:
        return CupertinoPageRoute(
            builder: (context) => ReferenceNumberPage(),
            settings: RouteSettings(name: RoutePaths.ReferenceNumber));

      case RoutePaths.TaxTreatyBenefits:
        return CupertinoPageRoute(
            builder: (context) =>
                ClaimOfTaxTreatyBenefitsPage(settings.arguments as ClaimOfTaxTreatyBenefitsArguments),
            settings: RouteSettings(name: RoutePaths.TaxTreatyBenefits));

      case RoutePaths.CardDelivery:
        return CupertinoPageRoute(
            builder: (context) => CardDeliveryPage(), settings: RouteSettings(name: RoutePaths.CardDelivery));

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
            builder: (context) => MyDocumentsPage(), settings: RouteSettings(name: RoutePaths.MyDocuments));

      case RoutePaths.ManageContactsList:
        return CupertinoPageRoute(
            builder: (context) => ManageContactListPage(),
            settings: RouteSettings(name: RoutePaths.ManageContactsList));

      case RoutePaths.ManageContactsDetail:
        return CupertinoPageRoute(
            builder: (context) => ManageContactDetailsPage(settings.arguments as Beneficiary),
            settings: RouteSettings(name: RoutePaths.ManageContactsDetail));

      case RoutePaths.DownloadTransaction:
        return CupertinoPageRoute(
            builder: (context) => DownloadTransactionPage(settings.arguments as DownloadStatementArguments),
            settings: RouteSettings(name: RoutePaths.DownloadTransaction));

      case RoutePaths.CardTransaction:
        return CustomRoute.createRoute(
            CardTransactionPage(settings.arguments as GetCreditCardTransactionArguments));

      case RoutePaths.AccountTransaction:
        return CustomRoute.createRoute(AccountTransactionPage());

      case RoutePaths.CreditCardDelivered:
        return CupertinoPageRoute(
            builder: (context) =>
                CreditCardDeliveredPage(creditCard: settings.arguments as TimeLineListArguments),
            settings: RouteSettings(name: RoutePaths.CreditCardDelivered));

      case RoutePaths.DebitCardDelivered:
        return CupertinoPageRoute(
            builder: (context) =>
                DebitCardDeliveredPage(debitCard: settings.arguments as TimeLineListArguments),
            settings: RouteSettings(name: RoutePaths.DebitCardDelivered));

      case RoutePaths.CreditCardVerificationSuccess:
        return CupertinoPageRoute(
            builder: (context) => CreditCardVerificationSuccessPage(),
            settings: RouteSettings(name: RoutePaths.CreditCardVerificationSuccess));

      case RoutePaths.DebitCardVerificationSuccess:
        return CupertinoPageRoute(
            builder: (context) => DebitCardVerificationSuccessPage(),
            settings: RouteSettings(name: RoutePaths.DebitCardVerificationSuccess));

      case RoutePaths.PaymentHome:
        return CustomRoute.createRoute(PaymentHomePage(navigationType: settings.arguments as NavigationType));

      case RoutePaths.ActivityHome:
        return CupertinoPageRoute(
            builder: (context) => ActivityHomePage(), settings: RouteSettings(name: RoutePaths.ActivityHome));

      case RoutePaths.RequestMoneyFailure:
        return CupertinoPageRoute(
            builder: (context) => RequestMoneyFailurePage(),
            settings: RouteSettings(name: RoutePaths.RequestMoneyFailure));

      case RoutePaths.SendMoneyFailure:
        return CupertinoPageRoute(
            builder: (context) => SendMoneyFailurePage(),
            settings: RouteSettings(name: RoutePaths.SendMoneyFailure));

      case RoutePaths.RequestAmountFromContact:
        return CustomRoute.createRoute(
            RequestAmountFromContactPage(beneficiary: settings.arguments as Beneficiary));

      case RoutePaths.SendAmountToContact:
        return CustomRoute.createRoute(SendAmountToContactPage(settings.arguments as Beneficiary));

      case RoutePaths.SendAmountToContactSuccess:
        return CupertinoPageRoute(
            builder: (context) => SendAmountToContactSuccessPage(
                  arguments: settings.arguments as TransferSuccessContent,
                ),
            settings: RouteSettings(name: RoutePaths.SendAmountToContactSuccess));

      case RoutePaths.SendMoney:
        return CustomRoute.createRoute(SendMoneyPage());

      case RoutePaths.RequestMoney:
        return CustomRoute.createRoute(RequestMoneyPage());

      case RoutePaths.RequestAmountFromContactSuccess:
        return CupertinoPageRoute(
            builder: (context) => RequestAmountFromContactSuccessPage(
                  successValues: settings.arguments as List<String>,
                ),
            settings: RouteSettings(name: RoutePaths.RequestAmountFromContactSuccess));

      case RoutePaths.RequestPaymentFromNewRecipient:
        return CupertinoPageRoute(
            builder: (context) =>
                RequestPaymentFromNewRecipientPage(requestValue: settings.arguments as String),
            settings: RouteSettings(name: RoutePaths.RequestPaymentFromNewRecipient));

      case RoutePaths.PaymentToNewRecipient:
        return CupertinoPageRoute(
            builder: (context) => PaymentToNewRecipientPage(sendValue: settings.arguments as String),
            settings: RouteSettings(name: RoutePaths.PaymentToNewRecipient));

      case RoutePaths.VideoKyc:
        return CupertinoPageRoute(
            builder: (context) => VideoKycPage(credentials: settings.arguments as VideKycCredentials),
            settings: RouteSettings(name: RoutePaths.VideoKyc));

      case RoutePaths.VideoKYCScheduled:
        return CupertinoPageRoute(
            builder: (context) => VideoCallScheduledPage(settings.arguments as VideoCallScheduledArguments),
            settings: RouteSettings(name: RoutePaths.VideoKYCScheduled));

      case RoutePaths.DebitCardSettings:
        return CustomRoute.createRoute(
            DebitCardSettingsPage(settings.arguments as DebitCardSettingsArguments));

      case RoutePaths.CreditCardSettings:
        return CustomRoute.createRoute(
            CreditCardSettingsPage(settings.arguments as CreditCardSettingsArguments));

      case RoutePaths.HelpCenter:
        return CupertinoPageRoute(
            builder: (context) => HelpCenterPage(), settings: RouteSettings(name: RoutePaths.HelpCenter));

      case RoutePaths.ActiveCallPage:
        return CupertinoPageRoute(
            builder: (context) => ActiveCallPage(), settings: RouteSettings(name: RoutePaths.ActiveCallPage));

      case RoutePaths.CallEndedPage:
        return CupertinoPageRoute(
            builder: (context) => CallEndedPage(), settings: RouteSettings(name: RoutePaths.CallEndedPage));

      case RoutePaths.ManageCardPin:
        return CustomRoute.createRoute(
          ManageCardPinPage(manageCardPinArguments: settings.arguments as ManageCardPinArguments),
        );

      case RoutePaths.CardPinUnBlockSuccess:
        return CupertinoPageRoute(
            builder: (context) => CardPinUnBlockSuccessPage(
                manageCardPinArguments: settings.arguments as ManageCardPinArguments),
            settings: RouteSettings(name: RoutePaths.CardPinUnBlockSuccess));

      case RoutePaths.DebitCardReplacement:
        return CupertinoPageRoute(
            builder: (context) =>
                DebitCardReplacementPage(settings.arguments as DebitCardReplacementArguments),
            settings: RouteSettings(name: RoutePaths.DebitCardReplacement));

      case RoutePaths.DebitCardReplacementSuccess:
        return CupertinoPageRoute(
            builder: (context) =>
                DebitCardReplacementSuccessPage(settings.arguments as DebitCardReplacementSuccessPageArgs),
            settings: RouteSettings(name: RoutePaths.DebitCardReplacementSuccess));

      case RoutePaths.manageDebitLimit:
        return CustomRoute.createRoute(
            ManageDebitCardLimitsPage(settings.arguments as ManageCardLimitsArguments));

      case RoutePaths.ManageCreditCardLimits:
        return CustomRoute.createRoute(
            ManageCreditCardLimitsPage(settings.arguments as ManageCreditCardLimitsArguments));

      case RoutePaths.ChangeCardPin:
        return CupertinoPageRoute(
            builder: (context) => ChangeCardPinPage(),
            settings: RouteSettings(name: RoutePaths.ChangeCardPin));

      case RoutePaths.ChangeCardPinSuccess:
        return CupertinoPageRoute(
            builder: (context) =>
                ChangeCardPinSuccessPage(settings.arguments as ChangeCardPinSuccessArguments),
            settings: RouteSettings(name: RoutePaths.ChangeCardPinSuccess));

      case RoutePaths.SupplementaryCreditCard:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryCreditCardPage(),
            settings: RouteSettings(name: RoutePaths.SupplementaryCreditCard));

      case RoutePaths.SupplementaryCreditCardReady:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryCreditCardReadyPage(),
            settings: RouteSettings(name: RoutePaths.SupplementaryCreditCardReady));

      case RoutePaths.SupplementaryDebitCard:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryDebitCardPage(),
            settings: RouteSettings(name: RoutePaths.SupplementaryDebitCard));

      case RoutePaths.SupplementaryCardInReview:
        return CupertinoPageRoute(
            builder: (context) =>
                SupplementaryCardInReviewPage(settings.arguments as SupplementaryCardInReviewArguments),
            settings: RouteSettings(name: RoutePaths.SupplementaryCardInReview));

      case RoutePaths.BlinkCreditCard:
        return CustomRoute.createRoute(BlinkCreditCardPage());

      case RoutePaths.CreditCardApplicationFailure:
        return CupertinoPageRoute(
            builder: (context) =>
                CreditCardApplicationFailurePage(settings.arguments as CreditCardApplicationFailureArguments),
            settings: RouteSettings(name: RoutePaths.CreditCardApplicationFailure));

      case RoutePaths.ApplyCreditCardHome:
        return CupertinoPageRoute(
            builder: (context) => ApplyCreditCardHomePage(),
            settings: RouteSettings(name: RoutePaths.ApplyCreditCardHome));

      case RoutePaths.AccountHold:
        return CupertinoPageRoute(
            builder: (context) => AccountHoldPage(settings.arguments as AccountHoldArguments),
            settings: RouteSettings(name: RoutePaths.AccountHold));

      case RoutePaths.ForgotPassword:
        return CupertinoPageRoute(
            builder: (context) => ForgotPasswordPage(),
            settings: RouteSettings(name: RoutePaths.ForgotPassword));

      case RoutePaths.CreditCardActivationStatus:
        return CupertinoPageRoute(
            builder: (context) => CreditCardActivationStatusPage(),
            settings: RouteSettings(name: RoutePaths.CreditCardActivationStatus));

      case RoutePaths.CreditCardApplySuccess:
        return CupertinoPageRoute(
            builder: (context) =>
                CreditCardApplySuccessPage(settings.arguments as CreditCardApplySuccessArguments),
            settings: RouteSettings(name: RoutePaths.CreditCardApplySuccess));

      case RoutePaths.ResetPasswordSuccess:
        return CupertinoPageRoute(
            builder: (context) => ResetPasswordSuccessPage(),
            settings: RouteSettings(name: RoutePaths.ResetPasswordSuccess));

      case RoutePaths.UploadDocumentLater:
        return CupertinoPageRoute(
            builder: (context) => UploadDocumentsLaterPage(),
            settings: RouteSettings(name: RoutePaths.UploadDocumentLater));

      case RoutePaths.OTPForChangeDevice:
        return CupertinoPageRoute(
            builder: (context) => OtpForChangeDeviceConfirmationPage(),
            settings: RouteSettings(name: RoutePaths.OTPForChangeDevice));

      case RoutePaths.ChangeDeviceSuccess:
        return CupertinoPageRoute(
            builder: (context) => ChangeDeviceSuccessPage(),
            settings: RouteSettings(name: RoutePaths.ChangeDeviceSuccess));

      case RoutePaths.SupplementaryDebitCardSuccess:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryDebitCardSuccessPage(),
            settings: RouteSettings(name: RoutePaths.SupplementaryDebitCardSuccess));

      case RoutePaths.CreditCardPayBack:
        return CustomRoute.createRoute(
          CreditCardPayBackPage(settings.arguments as CreditCardPayBackArguments),
        );

      case RoutePaths.CreditCardPayBackSuccess:
        return CupertinoPageRoute(
            builder: (context) =>
                CreditCardPayBackSuccessPage(settings.arguments as CreditCardPayBackSuccessArguments),
            settings: RouteSettings(name: RoutePaths.CreditCardPayBackSuccess));

      case RoutePaths.VideoCall:
        return CupertinoPageRoute(
            builder: (context) => VideoCallPage(), settings: RouteSettings(name: RoutePaths.VideoCall));

      case RoutePaths.CheckScheduledVideoCall:
        return CupertinoPageRoute(
            builder: (context) =>
                CheckScheduledVideoCallPage(settings.arguments as CheckVideoCallScheduledArguments),
            settings: RouteSettings(name: RoutePaths.CheckScheduledVideoCall));

      case RoutePaths.TimeLinePage:
        return CustomRoute.createRoute(DebitCardTimeLinePage(settings.arguments as TimeLinePageArguments));

      case RoutePaths.SupplementaryCreditCardActivationStatus:
        return CupertinoPageRoute(
            builder: (context) => SupplementaryCreditCardActivationStatusPage(
                settings.arguments as SupplementaryCreditCardActivationArguments),
            settings: RouteSettings(name: RoutePaths.SupplementaryCreditCardActivationStatus));

      case RoutePaths.AllContact:
        return CupertinoPageRoute(
            builder: (context) => AllContactPage(settings.arguments as AllContactArguments),
            settings: RouteSettings(name: RoutePaths.AllContact));

      case RoutePaths.CreditCardVideoCallInitiate:
        return CupertinoPageRoute(
            builder: (context) =>
                CreditCardVideoCallInitiatePage(settings.arguments as CreditCardVideoCallInitiateArgs),
            settings: RouteSettings(name: RoutePaths.CreditCardVideoCallInitiate));

      case RoutePaths.CreditCardVideoCallComplete:
        return CupertinoPageRoute(
            builder: (context) => CreditCardVideoCallCompletePage(),
            settings: RouteSettings(name: RoutePaths.CreditCardVideoCallComplete));

      case RoutePaths.CreditCardVideoKyc:
        return CupertinoPageRoute(
            builder: (context) =>
                CreditCardVideoKycPage(credentials: settings.arguments as CreditCardVideKycCredentials),
            settings: RouteSettings(name: RoutePaths.CreditCardVideoKyc));

      case RoutePaths.RequestMoneyQrGeneration:
        return CustomRoute.createRoute(RequestMoneyQrGenerationPage());

      case RoutePaths.QRScreen:
        return CupertinoPageRoute(
            builder: (context) => QrScreenPage(), settings: RouteSettings(name: RoutePaths.QRScreen));

      case RoutePaths.SendMoneyQrScanning:
        return CupertinoPageRoute(
            builder: (context) => SendMoneyQrScanningPage(),
            settings: RouteSettings(name: RoutePaths.SendMoneyQrScanning));

      case RoutePaths.SendMoneyQrScanningSuccess:
        return CupertinoPageRoute(
            builder: (context) => SendMoneyViaQrSuccessPage(),
            settings: RouteSettings(name: RoutePaths.SendMoneyQrScanningSuccess));

      case RoutePaths.CliqIdList:
        return CupertinoPageRoute(
            builder: (context) => CliqIdListPage(), settings: RouteSettings(name: RoutePaths.CliqIdList));

      case RoutePaths.CreateCliqId:
        return CupertinoPageRoute(
            builder: (context) => CreateCliqIdPage(), settings: RouteSettings(name: RoutePaths.CreateCliqId));

      case RoutePaths.CliqIdCreationSuccess:
        return CupertinoPageRoute(
            builder: (context) => CliqIdCreationSuccessPage(),
            settings: RouteSettings(name: RoutePaths.CliqIdCreationSuccess));

      case RoutePaths.EditAlias:
        return CupertinoPageRoute(
            builder: (context) => EditAliasPage(), settings: RouteSettings(name: RoutePaths.EditAlias));

      case RoutePaths.EditMobileNoCliq:
        return CupertinoPageRoute(
            builder: (context) => EditMobileNoCliqPage(),
            settings: RouteSettings(name: RoutePaths.EditMobileNoCliq));

      case RoutePaths.ChangeCountryRestriction:
        return CupertinoPageRoute(
            builder: (context) => ChangeCountryRestrictionPage(),
            settings: RouteSettings(name: RoutePaths.ChangeCountryRestriction));

      case RoutePaths.ManageCreditSettlement:
        return CupertinoPageRoute(
            builder: (context) => ManageCreditSettlementPage(
                manageCreditSettlementArguments: settings.arguments as ManageCreditSettlementArguments),
            settings: RouteSettings(name: RoutePaths.ManageCreditSettlement));

      case RoutePaths.ChangeCardPayment:
        return CupertinoPageRoute(
            builder: (context) => ChangeCardPaymentAccountPage(),
            settings: RouteSettings(name: RoutePaths.ChangeCardPayment));

      case RoutePaths.ChangeCardSettlementPercentage:
        return CupertinoPageRoute(
            builder: (context) => ChangeCardSettlementPercentagePage(
                changeCardSettlementPercentageArguments:
                    settings.arguments as ChangeCardSettlementPercentageArguments),
            settings: RouteSettings(name: RoutePaths.ChangeCardSettlementPercentage));

      case RoutePaths.ViewDebitCardSubscription:
        return CustomRoute.createRoute(
            ViewDebitCardSubscriptionPage(settings.arguments as ViewDebitCardSubscriptionArguments));

      case RoutePaths.DcChangeLinkedMobileNumber:
        return CustomRoute.createRoute(
            DcChangeLinkedMobileNumberPage(settings.arguments as DCChangeLinkedMobileNumberArguments));

      case RoutePaths.DcSettingCardDelivery:
        return CupertinoPageRoute(
            builder: (context) => DcSettingCardDeliveryPage(),
            settings: RouteSettings(name: RoutePaths.DcSettingCardDelivery));

      case RoutePaths.DcSettingCardReady:
        return CupertinoPageRoute(
            builder: (context) => DcSettingCardReadyPage(),
            settings: RouteSettings(name: RoutePaths.DcSettingCardReady));

      case RoutePaths.DcChangeMobileNumberSuccess:
        return CupertinoPageRoute(
            builder: (context) =>
                DcChangeMobileNumberSuccessPage(settings.arguments as DCChangeLinkedMobileNumberArguments),
            settings: RouteSettings(name: RoutePaths.DcChangeMobileNumberSuccess));

      case RoutePaths.RenewCreditCard:
        return CupertinoPageRoute(
            builder: (context) => RenewCreditCardPage(),
            settings: RouteSettings(name: RoutePaths.RenewCreditCard));

      case RoutePaths.ChangeCreditLimit:
        return CupertinoPageRoute(
            builder: (context) => ChangeCreditLimitPage(),
            settings: RouteSettings(name: RoutePaths.ChangeCreditLimit));

      case RoutePaths.ConvertPurchaseToInstallments:
        return CupertinoPageRoute(
            builder: (context) => ConvertPurchaseToInstallmentsPage(),
            settings: RouteSettings(name: RoutePaths.ConvertPurchaseToInstallments));

      case RoutePaths.Evoucher:
        return CupertinoPageRoute(
            builder: (context) => EvoucherPage(), settings: RouteSettings(name: RoutePaths.Evoucher));

      case RoutePaths.EvoucherDetail:
        return CupertinoPageRoute(
            builder: (context) => EvoucherDetailPage(),
            settings: RouteSettings(name: RoutePaths.EvoucherDetail));

      case RoutePaths.PurchaseNowDetail:
        return CupertinoPageRoute(
            builder: (context) => PurchaseNowDetailPage(),
            settings: RouteSettings(name: RoutePaths.PurchaseNowDetail));

      case RoutePaths.SupplementaryDebitCardPinSet:
        return CupertinoPageRoute(
            builder: (context) =>
                SupplementaryDebitCardPinSetPage(settings.arguments as SupplementaryDebitCardPinSetArguments),
            settings: RouteSettings(name: RoutePaths.SupplementaryDebitCardPinSet));

      case RoutePaths.EVouchersListing:
        return CupertinoPageRoute(
            builder: (context) => EVoucherCategoryListingPage(),
            settings: RouteSettings(name: RoutePaths.EVouchersListing));

      case RoutePaths.EVouchersPurchase:
        return CupertinoPageRoute(
            builder: (context) => PurchaseEVoucherPage(),
            settings: RouteSettings(name: RoutePaths.EVouchersPurchase));

      case RoutePaths.EVouchersPurchaseSuccess:
        return CupertinoPageRoute(
            builder: (context) => PurchaseVoucherSuccessPage(),
            settings: RouteSettings(name: RoutePaths.EVouchersPurchaseSuccess));

      case RoutePaths.ShareVoucher:
        return CupertinoPageRoute(
            builder: (context) => ShareVoucherPage(), settings: RouteSettings(name: RoutePaths.ShareVoucher));

      case RoutePaths.EVoucherMainPage:
        return CupertinoPageRoute(
            builder: (context) => EVoucherMainPage(),
            settings: RouteSettings(name: RoutePaths.EVoucherMainPage));

      case RoutePaths.EnterCodeEVoucherPurchase:
        return CupertinoPageRoute(
            builder: (context) => EnterCodeEVoucherPurchasePage(),
            settings: RouteSettings(name: RoutePaths.EnterCodeEVoucherPurchase));

      case RoutePaths.PaySelectedBillsPostPaidBillsPage:
        return CupertinoPageRoute(
            builder: (context) => PaySelectedBillsPostPaidBillsPage(
                settings.arguments as PaySelectedBillsPostPaidBillsPageArguments),
            settings: RouteSettings(name: RoutePaths.PaySelectedBillsPostPaidBillsPage));

      case RoutePaths.PayAllPostPaidBillsPage:
        return CupertinoPageRoute(
            builder: (context) =>
                PayAllPostPaidBillsPage(settings.arguments as PayAllPostPaidBillsPageArguments),
            settings: RouteSettings(name: RoutePaths.PayAllPostPaidBillsPage));

      case RoutePaths.LauncherPage:
        return CupertinoPageRoute(
            builder: (context) => LauncherPage(), settings: RouteSettings(name: RoutePaths.LauncherPage));

      case RoutePaths.PostPaidBillsSuccessPage:
        return CupertinoPageRoute(
            builder: (context) =>
                PostPaidBillsSuccessPage(settings.arguments as PostPaidBillsSuccessPageArguments),
            settings: RouteSettings(name: RoutePaths.PostPaidBillsSuccessPage));

      case RoutePaths.NewBillsPage:
        return CupertinoPageRoute(
            builder: (context) => NewBillsPage(), settings: RouteSettings(name: RoutePaths.NewBillsPage));

      case RoutePaths.PayBillPage:
        return CupertinoPageRoute(
            builder: (context) => PayBillPage(), settings: RouteSettings(name: RoutePaths.PayBillPage));

      case RoutePaths.PayBillDetailPage:
        return CupertinoPageRoute(
            builder: (context) => PayBillDetailPage(),
            settings: RouteSettings(name: RoutePaths.PayBillDetailPage));

      case RoutePaths.ConfirmBillPaymentAmountPage:
        return CupertinoPageRoute(
            builder: (context) => ConfirmBillPaymentAmountPage(),
            settings: RouteSettings(name: RoutePaths.ConfirmBillPaymentAmountPage));

      case RoutePaths.PaidBillsSuccessPage:
        return CupertinoPageRoute(
            builder: (context) => PaidBillsSuccessPage(settings.arguments as PaidBillsSuccessPageArguments),
            settings: RouteSettings(name: RoutePaths.PaidBillsSuccessPage));

      case RoutePaths.QRScanningScreen:
        return CupertinoPageRoute(
            builder: (context) => QrScanningScreenPage(),
            settings: RouteSettings(name: RoutePaths.QRScanningScreen));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
