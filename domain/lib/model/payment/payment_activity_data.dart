import 'package:domain/constants/enum/request_money_activity_enum.dart';

class PaymentActivityData {
  PaymentActivityData(
      {this.name, this.amount, this.status, this.rtpDate, this.profileImage});

  String? name;
  double? amount;
  RequestMoneyActivityStatusEnum? status;
  String? profileImage;
  DateTime? rtpDate;
}
