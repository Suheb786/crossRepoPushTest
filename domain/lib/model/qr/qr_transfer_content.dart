class QRTransferContent {
  final String transferDate;
  final String name;
  final String iban;
  final num amount;
  final String reference;

  QRTransferContent(
      {required this.name,
      required this.iban,
      required this.amount,
      required this.transferDate,
      required this.reference});
}
