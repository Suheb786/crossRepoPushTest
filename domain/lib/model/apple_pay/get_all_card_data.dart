class GetAllCardData {
  bool? isCardInApplePay;
  bool? getStatus;
  String? getIssuerCardId;

  GetAllCardData({this.isCardInApplePay, this.getStatus, this.getIssuerCardId});

  GetAllCardData.fromJson(Map<String, dynamic> json) {
    isCardInApplePay = json['isCardInApplePay'];
    getStatus = json['getStatus'];
    getIssuerCardId = json['getIssuerCardId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCardInApplePay'] = this.isCardInApplePay;
    data['getStatus'] = this.getStatus;
    data['getIssuerCardId'] = this.getIssuerCardId;
    return data;
  }
}
