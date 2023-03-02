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
      this.blinkRetailAppBillPaymentPayPrepaid});

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
        appBillPaymentPrepaid: this.blinkRetailAppBillPaymentPayPrepaid ?? false);
  }
}
