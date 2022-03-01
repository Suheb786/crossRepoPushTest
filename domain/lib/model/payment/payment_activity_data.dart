import 'package:domain/constants/enum/transaction_status_enum.dart';

class PaymentActivityData {
  PaymentActivityData(
      {this.name, this.amount, this.status, this.rtpDate, this.profileImage});

  String? name;
  double? amount;
  TransactionStatusEnum? status;
  String? profileImage;
  DateTime? rtpDate;
}
