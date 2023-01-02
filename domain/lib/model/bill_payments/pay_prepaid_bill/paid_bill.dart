class PaidBill {
  final String? billName;
  final String? billerNameAR;
  final dynamic totalAmount;
  final String? refNo;
  final String? date;
  final String? statusDescription;
  final bool? isPaid;

  PaidBill({
    this.billName,
    this.billerNameAR,
    this.totalAmount,
    this.refNo,
    this.date,
    this.statusDescription,
    this.isPaid,
  });
}
