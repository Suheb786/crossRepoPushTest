import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill.dart';

class PaidBillContent {
  final String? message;
  final List<PaidBill>? paidBill;

  PaidBillContent({this.message, this.paidBill});
}
