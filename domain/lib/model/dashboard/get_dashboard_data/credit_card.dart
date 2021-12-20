class CreditCard {
  CreditCard({
    this.name,
    this.availableBalance,
    this.accountNo,
    this.iban,
    this.cardNo,
    this.expiryDate,
  });

  String? name;
  double? availableBalance;
  String? accountNo;
  String? iban;
  String? cardNo;
  String? expiryDate;
}
