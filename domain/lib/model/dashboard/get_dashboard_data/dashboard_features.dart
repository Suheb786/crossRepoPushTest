class DashboardFeatures {
  final bool? isCreditCardFeatureEnabled;
  final bool? isRJFeatureEnabled;
  final bool? isLoginFeatureEnabled;
  final bool? isRegisterFeatureEnabled;
  final bool? isPinChangeEnabled;
  final bool? isDebitCardRequestPhysicalCardEnabled;
  final bool? appBillPaymentPostpaid;
  final bool? appBillPaymentPrepaid;
  final bool? appBillPaymentQrCode;
  final bool? blinkRetailAppBillPayment;
  final bool? blinkRetailAppCliq;
  final bool? blinkRetailAppCliqAliasManagement;
  final bool? blinkRetailAppCliqRTP;
  final bool? blinkRetailAppCliqSendPayment;

  DashboardFeatures(
      {this.appBillPaymentPostpaid,
      this.appBillPaymentQrCode,
      this.isCreditCardFeatureEnabled,
      this.isRJFeatureEnabled,
      this.isLoginFeatureEnabled,
      this.isRegisterFeatureEnabled,
      this.isPinChangeEnabled,
      this.isDebitCardRequestPhysicalCardEnabled,
      this.blinkRetailAppBillPayment,
      this.appBillPaymentPrepaid,
      this.blinkRetailAppCliqSendPayment,
      this.blinkRetailAppCliq,
      this.blinkRetailAppCliqAliasManagement,
      this.blinkRetailAppCliqRTP});
}
