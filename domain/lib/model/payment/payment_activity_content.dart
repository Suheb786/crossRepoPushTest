import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_data.dart';

class PaymentActivityContent {
  PaymentActivityContent({
    this.rtpDate,
    this.data,
  });

  DateTime? rtpDate;
  List<RequestMoneyActivityList>? data;
}
