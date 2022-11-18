class PaidBill {
  final String? billName;

  final dynamic totalAmount;

  final String? refNo;

  final String? date;

  final String? statusDescription;

  final bool? isPaid;

  PaidBill(
      {this.billName,
      this.totalAmount,
      this.refNo,
      this.date,
      this.statusDescription,
        this.isPaid,
      });
}
