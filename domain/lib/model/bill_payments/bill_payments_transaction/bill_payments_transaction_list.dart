class BillPaymentsTransactionList {
  String? nickname;
  String? billingNumber;
  String? billerName;
  String? billerCode;
  String? billNo;
  String? amount;
  String? fees;
  String? paymentDate;
  String? serviceType;
  String? serviceCode;
  String? categoryName;
  String? iconCode;
  bool? isPaid;

  BillPaymentsTransactionList({
    this.nickname,
    this.billingNumber,
    this.billerName,
    this.billerCode,
    this.billNo,
    this.amount,
    this.fees,
    this.paymentDate,
    this.serviceType,
    this.serviceCode,
    this.iconCode,
    this.categoryName,
    this.isPaid,
  });
}
