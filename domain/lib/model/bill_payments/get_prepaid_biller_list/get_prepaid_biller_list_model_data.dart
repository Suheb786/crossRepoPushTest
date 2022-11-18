class GetPrepaidBillerListModelData {
  String? billingNumber;
  String? billerCode;
  String? billerName;
  String? nickname;
  String? registrationId;
  String? prepaidCategoryDescription;
  String? prepaidCategoryCode;
  String? customerType;
  String? joebppsNo;
  String? serviceType;
  String? serviceCode;
  String? iconCode;
  String? serviceDescriptionEn; //this is not coming from api
  bool? isChecked; //this is not coming from api

  GetPrepaidBillerListModelData(
      {this.billingNumber,
      this.billerCode,
      this.billerName,
      this.nickname,
      this.registrationId,
      this.prepaidCategoryDescription,
      this.prepaidCategoryCode,
      this.customerType,
      this.joebppsNo,
      this.serviceType,
      this.serviceCode,
      this.iconCode,
      this.serviceDescriptionEn, //this is not coming from api
      this.isChecked = false //this is not coming from api
      });
}
