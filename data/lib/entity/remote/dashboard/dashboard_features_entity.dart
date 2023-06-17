import 'package:domain/model/dashboard/get_dashboard_data/dashboard_features.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_features_entity.g.dart";

@JsonSerializable()
class DashboardFeaturesEntity
    implements BaseLayerDataTransformer<DashboardFeaturesEntity, DashboardFeatures> {
  @JsonKey(name: "blink-retail-app-login")
  final bool? isLoginEnabled;

  @JsonKey(name: "blink-retail-app-creditCards-application")
  final bool? isCreditCardEnabled;

  @JsonKey(name: "blink-retail-app-register")
  final bool? isRegisterEnabled;

  @JsonKey(name: "blink-retail-app-gorj")
  final bool? isGoRJEnabled;

  @JsonKey(name: "blink-retail-app-creditCards-pinchange")
  final bool? isCreditCardPinChangeEnabled;

  @JsonKey(name: "blink-retail-app-debit-card-physical-card-request")
  final bool? isDebitCardPhysicalCardRequestEnabled;

  @JsonKey(name: "blink-retail-app-bill-payment")
  final bool? blinkRetailAppBillPayment;

  @JsonKey(name: "blink-retail-app-bill-payment-pay-postpaid")
  final bool? blinkRetailAppBillPaymentPayPostpaid;

  @JsonKey(name: "blink-retail-app-bill-payment-pay-prepaid")
  final bool? blinkRetailAppBillPaymentPayPrepaid;

  @JsonKey(name: "blink-retail-app-payments-qrcode")
  final bool? paymentQRCode;

  @JsonKey(name: "blink-retail-app-cliq")
  final bool? blinkRetailAppCliq;

  @JsonKey(name: "blink-retail-app-cliq-alias-management")
  final bool? blinkRetailAppAliasManagement;

  @JsonKey(name: "blink-retail-app-cliq-rtp")
  final bool? blinkRetailAppRTP;

  @JsonKey(name: "blink-retail-app-cliq-send-payment")
  final bool? blinkRetailAppCliqSendPayment;

  @JsonKey(name: "blink-retail-app-cliq-rtp-outward")
  final bool? rtpFeatureEnabled;

  @JsonKey(name: "blink-retail-app-cliq-return-payment")
  final bool? returnPaymentFeatureEnabled;

  @JsonKey(name: "blink-retail-app-manage-contacts")
  final bool? manageContactEnabled;

  DashboardFeaturesEntity(
      {this.blinkRetailAppBillPayment,
      this.blinkRetailAppBillPaymentPayPostpaid,
      this.paymentQRCode,
      this.isCreditCardEnabled,
      this.isGoRJEnabled,
      this.isLoginEnabled,
      this.isRegisterEnabled,
      this.isCreditCardPinChangeEnabled,
      this.isDebitCardPhysicalCardRequestEnabled,
      this.blinkRetailAppBillPaymentPayPrepaid,
      this.blinkRetailAppAliasManagement,
      this.blinkRetailAppCliq,
      this.blinkRetailAppCliqSendPayment,
      this.blinkRetailAppRTP,
      this.rtpFeatureEnabled,
      this.returnPaymentFeatureEnabled,
      this.manageContactEnabled});

  factory DashboardFeaturesEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardFeaturesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardFeaturesEntityToJson(this);

  @override
  DashboardFeaturesEntity restore(DashboardFeatures response) {
    return DashboardFeaturesEntity();
  }

  @override
  DashboardFeatures transform() {
    return DashboardFeatures(
        isCreditCardFeatureEnabled: isCreditCardEnabled ?? false,
        isLoginFeatureEnabled: isLoginEnabled ?? false,
        isRegisterFeatureEnabled: isRegisterEnabled ?? false,
        isRJFeatureEnabled: isGoRJEnabled ?? false,
        isPinChangeEnabled: this.isCreditCardPinChangeEnabled ?? false,
        isDebitCardRequestPhysicalCardEnabled: this.isDebitCardPhysicalCardRequestEnabled ?? false,
        blinkRetailAppBillPayment: this.blinkRetailAppBillPayment ?? false,
        appBillPaymentPostpaid: this.blinkRetailAppBillPaymentPayPostpaid ?? false,
        appBillPaymentQrCode: this.paymentQRCode ?? false,
        appBillPaymentPrepaid: this.blinkRetailAppBillPaymentPayPrepaid ?? false,
        blinkRetailAppCliq: this.blinkRetailAppCliq ?? false,
        blinkRetailAppCliqAliasManagement: this.blinkRetailAppAliasManagement ?? false,
        blinkRetailAppCliqRTP: blinkRetailAppRTP ?? false,
        blinkRetailAppCliqSendPayment: blinkRetailAppCliqSendPayment ?? false,
        rtpFeatureEnabled: rtpFeatureEnabled ?? false,
        returnPaymentFeatureEnabled: returnPaymentFeatureEnabled ?? false,
        manageContactEnabled: /*this.manageContactEnabled ?? false*/ true);
  }
}
