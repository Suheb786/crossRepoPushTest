class PostPaidBillInquiryData {
  PostPaidBillInquiryData({
    this.billerCode,
    this.billingNo,
    this.billNo,
    this.dueDate,
    this.serviceType,
    this.dueAmount,
    this.feesAmt,
    this.minValue,
    this.maxValue,
    this.success,
    this.message,
    this.inqRefNo,
    this.isPartial,
    this.minMaxValidationMessage,
    this.actualDueAmountFromApi,
  });

  String? billerCode;
  String? billingNo;
  String? billNo;
  String? dueDate;
  String? serviceType;
  String? dueAmount;
  String? feesAmt;
  String? maxValue;
  String? minValue;
  bool? success;
  dynamic message;
  String? inqRefNo;
  bool? isPartial;
  String? minMaxValidationMessage;
  String? actualDueAmountFromApi;
}
