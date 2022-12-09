class AccountList {
  final String? recordId;
  final String? bic;
  final String? acciban;
  final String? openingDate;
  final String? closingDate;
  final String? currency;
  final String? type;
  final bool? isDefault;

  AccountList({
    required this.recordId,
    required this.bic,
    required this.acciban,
    required this.openingDate,
    required this.closingDate,
    required this.currency,
    required this.type,
    required this.isDefault,
  });
}
