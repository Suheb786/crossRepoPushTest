class GetAccountDetailsContentData {
  GetAccountDetailsContentData({
    this.accountDate,
    this.name,
    this.accountNumber,
    this.iban,
    this.cif,
    this.promoCode,
    this.balance,
    this.currencyCode,
    this.zPoints,
    this.dailyLimitLeft,
    this.dailyTransferLimit,
    this.bankName,
    this.countryName,
    this.swiftCode,
    this.cardNumber,
  });

  final String? accountDate;
  final String? name;
  final String? accountNumber;
  final String? iban;
  final String? cif;
  final dynamic promoCode;
  final String? balance;
  final String? currencyCode;
  final int? zPoints;
  List<dynamic>? dailyLimitLeft;
  final dynamic dailyTransferLimit;
  final String? bankName;
  final String? countryName;
  final String? swiftCode;
  final String? cardNumber;
}
