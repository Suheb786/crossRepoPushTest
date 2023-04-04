import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';

class PaymentActivityContent {
  PaymentActivityContent({
    this.activityDate,
    this.data,
  });

  DateTime? activityDate;
  List<RequestMoneyActivityList>? data;
}
