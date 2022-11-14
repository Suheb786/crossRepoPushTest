import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill_conent.dart';

class PayPrePaid {
  String? requestDateTime;
  String? logId;
  PaidBillContent? content;


  PayPrePaid({
    this.requestDateTime,
    this.logId,
     this.content,
  });
}
