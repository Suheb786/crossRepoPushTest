class TransferSuccessContent {
  final num? amount;
  final String? name;
  final String? iban;
  final DateTime? transferDate;
  final String? referenceNo;
  String paymentMadeTo;

  TransferSuccessContent(
      {this.amount, this.name, this.iban, this.transferDate, this.referenceNo, this.paymentMadeTo = ''});
}
