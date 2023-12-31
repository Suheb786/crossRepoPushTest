// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_features_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardFeaturesEntity _$DashboardFeaturesEntityFromJson(
        Map<String, dynamic> json) =>
    DashboardFeaturesEntity(
      blinkRetailAppBillPayment: json['blink-retail-app-bill-payment'] as bool?,
      blinkRetailAppBillPaymentPayPostpaid:
          json['blink-retail-app-bill-payment-pay-postpaid'] as bool?,
      paymentQRCode: json['blink-retail-app-payments-qrcode'] as bool?,
      isCreditCardEnabled:
          json['blink-retail-app-creditCards-application'] as bool?,
      isGoRJEnabled: json['blink-retail-app-gorj'] as bool?,
      isLoginEnabled: json['blink-retail-app-login'] as bool?,
      isRegisterEnabled: json['blink-retail-app-register'] as bool?,
      isCreditCardPinChangeEnabled:
          json['blink-retail-app-creditCards-pinchange'] as bool?,
      isDebitCardPhysicalCardRequestEnabled:
          json['blink-retail-app-debit-card-physical-card-request'] as bool?,
      blinkRetailAppBillPaymentPayPrepaid:
          json['blink-retail-app-bill-payment-pay-prepaid'] as bool?,
      blinkRetailAppAliasManagement:
          json['blink-retail-app-cliq-alias-management'] as bool?,
      blinkRetailAppCliq: json['blink-retail-app-cliq'] as bool?,
      blinkRetailAppCliqSendPayment:
          json['blink-retail-app-cliq-send-payment'] as bool?,
      blinkRetailAppRTP: json['blink-retail-app-cliq-rtp'] as bool?,
      rtpFeatureEnabled: json['blink-retail-app-cliq-rtp-outward'] as bool?,
      returnPaymentFeatureEnabled:
          json['blink-retail-app-cliq-return-payment'] as bool?,
      manageContactEnabled: json['blink-retail-app-manage-contacts'] as bool?,
      manageContactHistory:
          json['blink-retail-app-manage-contacts-History'] as bool?,
      eVouchers: json['blink-retail-app-E-vouchers'] as bool?,
      blinkRetailAppApplePay: json['blink-retail-app-applepay'] as bool?,
      subAccountFeature: json['blink-retail-app-Sub-Accounts'] as bool?,
      closeSubAccountFeature:
          json['blink-retail-app-Sub-Accounts-Close-Sub-Account'] as bool?,
      shareAccountInformationFeature:
          json['blink-retail-app-Sub-Accounts-Share-Account-Information']
              as bool?,
      transferBetweenAccountsFeature:
          json['blink-retail-app-Sub-Accounts-Transfer-Between-Accounts']
              as bool?,
      offers: json['blink-retail-app-Offers'] as bool?,
      referrals: json['blink-retail-app-Referrals'] as bool?,
    );

Map<String, dynamic> _$DashboardFeaturesEntityToJson(
        DashboardFeaturesEntity instance) =>
    <String, dynamic>{
      'blink-retail-app-login': instance.isLoginEnabled,
      'blink-retail-app-creditCards-application': instance.isCreditCardEnabled,
      'blink-retail-app-register': instance.isRegisterEnabled,
      'blink-retail-app-gorj': instance.isGoRJEnabled,
      'blink-retail-app-creditCards-pinchange':
          instance.isCreditCardPinChangeEnabled,
      'blink-retail-app-debit-card-physical-card-request':
          instance.isDebitCardPhysicalCardRequestEnabled,
      'blink-retail-app-bill-payment': instance.blinkRetailAppBillPayment,
      'blink-retail-app-bill-payment-pay-postpaid':
          instance.blinkRetailAppBillPaymentPayPostpaid,
      'blink-retail-app-bill-payment-pay-prepaid':
          instance.blinkRetailAppBillPaymentPayPrepaid,
      'blink-retail-app-payments-qrcode': instance.paymentQRCode,
      'blink-retail-app-cliq': instance.blinkRetailAppCliq,
      'blink-retail-app-cliq-alias-management':
          instance.blinkRetailAppAliasManagement,
      'blink-retail-app-cliq-rtp': instance.blinkRetailAppRTP,
      'blink-retail-app-cliq-send-payment':
          instance.blinkRetailAppCliqSendPayment,
      'blink-retail-app-cliq-rtp-outward': instance.rtpFeatureEnabled,
      'blink-retail-app-cliq-return-payment':
          instance.returnPaymentFeatureEnabled,
      'blink-retail-app-manage-contacts': instance.manageContactEnabled,
      'blink-retail-app-manage-contacts-History': instance.manageContactHistory,
      'blink-retail-app-E-vouchers': instance.eVouchers,
      'blink-retail-app-applepay': instance.blinkRetailAppApplePay,
      'blink-retail-app-Sub-Accounts': instance.subAccountFeature,
      'blink-retail-app-Sub-Accounts-Transfer-Between-Accounts':
          instance.transferBetweenAccountsFeature,
      'blink-retail-app-Sub-Accounts-Close-Sub-Account':
          instance.closeSubAccountFeature,
      'blink-retail-app-Sub-Accounts-Share-Account-Information':
          instance.shareAccountInformationFeature,
      'blink-retail-app-Offers': instance.offers,
      'blink-retail-app-Referrals': instance.referrals,
    };
