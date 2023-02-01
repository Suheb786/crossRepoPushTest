class AddNewDetailsBillPaymentsModel {
   String? amount;
  String? actualAmountFromApi;
  String? nickName;
  String? billerName;
  String? service;
  String? refNo;
  bool? isPrepaidCategoryListEmpty;
  String? accountNumber;

  AddNewDetailsBillPaymentsModel({
    this.amount,
    this.actualAmountFromApi,
    this.nickName,
    this.billerName,
    this.service,
    this.refNo,
    this.isPrepaidCategoryListEmpty,
    this.accountNumber,
  });
}
