class CreditCardLimit {
  final bool? isATM;
  final String? atmCurrentLimit;
  final String? atmMaxLimit;
  final bool? isMerchant;
  final String? merchantCurrentLimit;
  final String? merchantMaxLimit;
  final bool? isOnlinePurchase;
  final String? onlinePurchaseCurrentLimit;
  final String? onlinePurchaseMaxLimit;
  final bool? isContactLess;
  final String? contactLessCurrentLimit;
  final String? contactLessMaxLimit;

  CreditCardLimit(
      {this.isATM,
      this.atmCurrentLimit,
      this.atmMaxLimit,
      this.isMerchant,
      this.merchantCurrentLimit,
      this.merchantMaxLimit,
      this.isOnlinePurchase,
      this.onlinePurchaseCurrentLimit,
      this.onlinePurchaseMaxLimit,
      this.isContactLess,
      this.contactLessCurrentLimit,
      this.contactLessMaxLimit});
}
