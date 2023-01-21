import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_list.dart';

class BillPaymentsTransactionData {
  String? label;
  List<BillPaymentsTransactionList>? billPaymentsTransactionDataList;

  BillPaymentsTransactionData({
    this.label,
    this.billPaymentsTransactionDataList,
  });
}
