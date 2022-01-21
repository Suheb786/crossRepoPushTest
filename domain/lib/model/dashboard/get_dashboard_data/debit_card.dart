class DebitCard {
  DebitCard(
      {this.accountTitle,
      this.cardNumber,
      this.linkedAccountNumber,
      this.expiryDate,
      this.cvv,
      this.cardStatus,
      this.debitCardActivated,
      this.isDebitDelivered,
      this.debitDeliveredDatetime,
      this.code});

  String? accountTitle;
  String? cardNumber;
  String? linkedAccountNumber;
  String? expiryDate;
  String? cvv;
  String? cardStatus;
  String? code;
  bool? isDebitDelivered;
  dynamic? debitDeliveredDatetime;
  DateTime? debitCardActivated;
}
