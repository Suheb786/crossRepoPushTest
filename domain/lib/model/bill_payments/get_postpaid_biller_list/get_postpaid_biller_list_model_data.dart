class GetPostpaidBillerListModelData {
  String? joebppsNo;
  String? customerId;
  String? billerCode;
  String? billingNo;
  String? serviceType;
  String? billingStatus;
  String? nickName;
  String? billerNameEN;
  String? billerNameAR;
  String? billerCatogaryEN;
  String? billerCatogaryAR;
  String? serviceTypeDescEN;
  String? serviceTypeAR;
  String? dueAmount;
  String? dueDate;
  String? fees;
  String? status;
  bool? isChecked;
  String? iconCode;
  bool? isAmountUpdatedFromApi; //
  String? actualdueAmountFromApi;
  bool? isPartial;
  String? maxValue;
  String? minValue;
  bool? expDateStatus;
  String? expDateMessage;

  GetPostpaidBillerListModelData({
    this.joebppsNo,
    this.customerId,
    this.billerCode,
    this.billingNo,
    this.serviceType,
    this.billingStatus,
    this.nickName,
    this.billerNameEN,
    this.billerNameAR,
    this.billerCatogaryEN,
    this.billerCatogaryAR,
    this.serviceTypeDescEN,
    this.serviceTypeAR,
    this.dueAmount,
    this.dueDate,
    this.fees,
    this.status,
    this.iconCode,
    this.isChecked = false,
    this.isPartial = false,
    this.isAmountUpdatedFromApi = false,
    this.actualdueAmountFromApi = "0.000",
    this.maxValue = "0.000",
    this.minValue = "0.000",
    this.expDateStatus,
    this.expDateMessage,
  });
}
