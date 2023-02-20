import 'package:domain/constants/enum/transaction_status_bills_enum.dart';

class BillPaymentsTransactionList {
  String? nickname;
  String? billingNumber;
  String? billerName;
  String? billerNameAr;
  String? billerCode;
  String? billNo;
  String? amount;
  String? fees;
  String? paymentDate;
  String? serviceType;
  String? serviceCode;
  String? categoryName;
  String? iconCode;
  String? refNo;
  TransactionStatusBillsEnum? status;

  BillPaymentsTransactionList({
    this.nickname,
    this.billingNumber,
    this.billerName,
    this.billerNameAr,
    this.billerCode,
    this.billNo,
    this.amount,
    this.fees,
    this.paymentDate,
    this.serviceType,
    this.serviceCode,
    this.iconCode,
    this.refNo,
    this.categoryName,
    this.status,
  });
}
