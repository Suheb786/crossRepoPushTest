class CreditCard {
  CreditCard({
    this.name,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.minDue,
    this.availableBalance,
    this.totalAmount,
    this.maxLimit,
  });

  String? name;
  String? cardNumber;
  String? expiryDate;
  String? cvv;
  num? minDue;
  num? availableBalance;
  num? totalAmount;
  num? maxLimit;
}
