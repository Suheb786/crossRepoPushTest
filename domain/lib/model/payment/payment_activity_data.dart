class PaymentActivityData {
  PaymentActivityData(
      {this.name, this.amount, this.status, this.rtpDate, this.profileImage});

  String? name;
  double? amount;
  String? status;
  String? profileImage;
  DateTime? rtpDate;
}
