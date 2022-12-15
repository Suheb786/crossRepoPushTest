class PostPaidBillInquiryData {
  PostPaidBillInquiryData({
    this.billerCode,
    this.billingNo,
    this.billNo,
    this.dueDate,
    this.serviceType,
    this.dueAmount,
    this.feesAmt,
    this.success,
    this.message,
    this.isPartial,
  });

  String? billerCode;
  String? billingNo;
  String? billNo;
  String? dueDate;
  String? serviceType;
  String? dueAmount;
  String? feesAmt;
  bool? success;
  dynamic message;
  bool? isPartial;
}
