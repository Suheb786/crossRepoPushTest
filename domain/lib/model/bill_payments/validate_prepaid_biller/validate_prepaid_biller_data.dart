class ValidatePrePaidBillData {
  final bool? success;
  final String? message;
  final String? billerCode;
  final String? billingNo;
  final String? customerName;
  final String? dueAmount;
  final String? feesAmount;
  final String? validationCode;

  ValidatePrePaidBillData(
      {this.success,
      this.message,
      this.billerCode,
      this.billingNo,
      this.customerName,
      this.dueAmount,
      this.feesAmount,
      this.validationCode});
}
