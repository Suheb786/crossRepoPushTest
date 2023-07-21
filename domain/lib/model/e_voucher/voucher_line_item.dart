class VoucherLineItem {
  int? lineNumber;
  String? cardItemId;
  num? value;
  String? status;
  String? claimURL;
  String? cardItemName;
  String? currency;

  VoucherLineItem({
    required this.lineNumber,
    required this.cardItemId,
    required this.value,
    required this.status,
    required this.claimURL,
    required this.cardItemName,
    required this.currency,
  });
}
