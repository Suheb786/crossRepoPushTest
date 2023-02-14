class PostpaidBillInquiry {
  PostpaidBillInquiry({
    this.billerCode,
    this.serviceType,
    this.billingNumber,
    this.billerName,
    this.amount,
    this.dueAmount,
    this.fees,
    this.nickName,
    this.inqRefNo,
    this.isPartialAllowed,
  });

  String? billerCode;
  String? serviceType;
  String? billingNumber;
  String? billerName;
  String? amount;
  String? dueAmount;
  String? fees;
  String? nickName;
  String? inqRefNo;
  bool? isPartialAllowed;

  factory PostpaidBillInquiry.fromJson(Map<String, dynamic> json) => PostpaidBillInquiry(
        billerCode: json["billerCode"],
        serviceType: json["serviceType"],
        billingNumber: json["billingNumber"],
        billerName: json["billerName"],
        amount: json["amount"],
        dueAmount: json["dueAmount"],
        fees: json["fees"],
        nickName: json["nickName"],
        isPartialAllowed: json["isPartialAllowed"],
        inqRefNo: json["inqRefNo"],
      );

  Map<String, dynamic> toJson() => {
        "billerCode": billerCode,
        "serviceType": serviceType,
        "billingNumber": billingNumber,
        "billerName": billerName,
        "amount": amount,
        "dueAmount": dueAmount,
        "fees": fees,
        "nickName": nickName,
        "isPartialAllowed": isPartialAllowed,
        "inqRefNo": inqRefNo,
      };
}
