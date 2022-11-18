class PostpaidBillInquiry {
  PostpaidBillInquiry({
    this.billerCode,
    this.serviceType,
    this.billingNumber,
    this.billerName,
    this.amount,
    this.fees,
  });

  String? billerCode;
  String? serviceType;
  String? billingNumber;
  String? billerName;
  String? amount;
  String? fees;

  factory PostpaidBillInquiry.fromJson(Map<String, dynamic> json) =>
      PostpaidBillInquiry(
        billerCode: json["billerCode"],
        serviceType: json["serviceType"],
        billingNumber: json["billingNumber"],
        billerName: json["billerName"],
        amount: json["amount"],
        fees: json["fees"],
      );

  Map<String, dynamic> toJson() => {
        "billerCode": billerCode,
        "serviceType": serviceType,
        "billingNumber": billingNumber,
        "billerName": billerName,
        "amount": amount,
        "fees": fees,
      };
}
