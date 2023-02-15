class GetAccountByCustomerId {
  final String? recordId;
  final String? acciban;
  final String? bic;
  final dynamic openingDate;
  final dynamic closingDate;
  final String? currency;
  final String? type;
  final String? accountType;
  final String? accountNumber;

  GetAccountByCustomerId(
      {this.recordId,
      this.acciban,
      this.bic,
      this.openingDate,
      this.closingDate,
      this.currency,
      this.type,
      this.accountType,
      this.accountNumber});
}
