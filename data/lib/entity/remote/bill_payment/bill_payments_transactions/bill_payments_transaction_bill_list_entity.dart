import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_payments_transaction_bill_list_entity.g.dart';

@JsonSerializable()
class BillPaymentsTransactionListEntity
    extends BaseLayerDataTransformer<BillPaymentsTransactionListEntity, BillPaymentsTransactionList> {
  @JsonKey(name: "nickname")
  final String? nickname;

  @JsonKey(name: "billingNumber")
  final String? billingNumber;

  @JsonKey(name: "billerName")
  final String? billerName;

  @JsonKey(name: "billerNameAr")
  final String? billerNameAr;

  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billNo")
  final String? billNo;

  @JsonKey(name: "amount")
  final String? amount;

  @JsonKey(name: "fees")
  final String? fees;

  @JsonKey(name: "paymentDate")
  final String? paymentDate;

  @JsonKey(name: "serviceType")
  final String? serviceType;

  @JsonKey(name: "serviceCode")
  final String? serviceCode;

  @JsonKey(name: "categoryName")
  final String? categoryName;

  @JsonKey(name: "iconCode")
  final String? iconCode;

  @JsonKey(name: "transactionRefrenceNo")
  final String? refNo;

  @JsonKey(name: "status")
  final bool? isPaid;

  BillPaymentsTransactionListEntity({
    this.nickname,
    this.billingNumber,
    this.billerName,
    this.billerNameAr,
    this.billerCode,
    this.billNo,
    this.amount,
    this.fees,
    this.paymentDate,
    this.serviceCode,
    this.serviceType,
    this.categoryName,
    this.iconCode,
    this.refNo,
    this.isPaid,
  });

  factory BillPaymentsTransactionListEntity.fromJson(Map<String, dynamic> json) =>
      _$BillPaymentsTransactionListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BillPaymentsTransactionListEntityToJson(this);

  @override
  BillPaymentsTransactionListEntity restore(BillPaymentsTransactionList data) {
    return BillPaymentsTransactionListEntity();
  }

  @override
  BillPaymentsTransactionList transform() {
    return BillPaymentsTransactionList(
      nickname: this.nickname ?? "",
      billingNumber: this.billingNumber ?? "",
      billerName: this.billerName ?? "",
      billerNameAr: this.billerNameAr ?? "",
      billerCode: this.billerCode ?? "",
      billNo: this.billNo ?? "0",
      amount: this.amount != null && this.amount!.isNotEmpty ? this.amount.toString() : "0",
      fees: this.fees != null && this.fees!.isNotEmpty ? this.fees.toString() : "0",
      paymentDate: this.paymentDate ?? "",
      serviceCode: this.serviceCode ?? "",
      serviceType: this.serviceType ?? "",
      categoryName: this.categoryName ?? "",
      iconCode: this.iconCode ?? "",
      refNo: this.refNo ?? "",
      isPaid: this.isPaid ?? false,
    );
  }
}
