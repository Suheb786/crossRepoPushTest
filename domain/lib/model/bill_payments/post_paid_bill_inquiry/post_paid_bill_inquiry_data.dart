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
    this.IsPartial,
  });

  String? billerCode;
  String? billingNo;
  String? billNo;
  DateTime? dueDate;
  String? serviceType;
  String? dueAmount;
  String? feesAmt;
  bool? success;
  dynamic message;
  bool? IsPartial;
}
