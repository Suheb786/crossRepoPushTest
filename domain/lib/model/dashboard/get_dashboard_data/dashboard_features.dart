class DashboardFeatures {
  final bool? isCreditCardFeatureEnabled;
  final bool? isRJFeatureEnabled;
  final bool? isLoginFeatureEnabled;
  final bool? isRegisterFeatureEnabled;
  final bool? isPinChangeEnabled;
  final bool? isDebitCardRequestPhysicalCardEnabled;
  final bool? appBillPaymentPostpaid;
  final bool? appBillPaymentQrCode;
  final bool? blinkRetailAppBillPayment;

  DashboardFeatures(
      {this.appBillPaymentPostpaid,
      this.appBillPaymentQrCode,
      this.isCreditCardFeatureEnabled,
      this.isRJFeatureEnabled,
      this.isLoginFeatureEnabled,
      this.isRegisterFeatureEnabled,
      this.isPinChangeEnabled,
      this.isDebitCardRequestPhysicalCardEnabled,
      this.blinkRetailAppBillPayment});
}
