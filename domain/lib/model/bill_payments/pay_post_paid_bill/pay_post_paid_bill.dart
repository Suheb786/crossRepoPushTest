import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill_list.dart';

class PayPostPaidBill {
  final PayPostPaidBillList? content;
  final dynamic requestDateTime;
  final dynamic logId;

  PayPostPaidBill({
    this.content,
    this.requestDateTime,
    this.logId,
  });
}
