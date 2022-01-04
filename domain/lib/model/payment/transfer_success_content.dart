class TransferSuccessContent {
  final num? amount;
  final String? name;
  final String? iban;
  final DateTime? transferDate;
  final String? referenceNo;

  TransferSuccessContent(
      {this.amount, this.name, this.iban, this.transferDate, this.referenceNo});
}
