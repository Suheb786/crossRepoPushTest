import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paid_bill_entity.g.dart';

@JsonSerializable()
class PaidBillEntity
    extends BaseLayerDataTransformer<PaidBillEntity, PaidBill> {
  @JsonKey(name: "billerName")
  final String? billName;

  @JsonKey(name: "totalAmount")
  final String? totalAmount;

  @JsonKey(name: "refNo")
  final String? refNo;

  @JsonKey(name: "date")
  final String? date;

  @JsonKey(name: "statusDescription")
  final String? statusDescription;

  @JsonKey(name: "isPaid")
  final bool? isPaid;

  PaidBillEntity(
      {this.billName,
      this.totalAmount,
      this.refNo,
      this.date,
      this.statusDescription,
      this.isPaid});

  factory PaidBillEntity.fromJson(Map<String, dynamic> json) =>
      _$PaidBillEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaidBillEntityToJson(this);

  @override
  PaidBillEntity restore(PaidBill data) {
    return PaidBillEntity();
  }

  @override
  PaidBill transform() {
    return PaidBill(
        billName: this.billName,
        totalAmount: this.totalAmount,
        refNo: this.refNo,
        date: this.date,
        statusDescription: this.statusDescription,
        isPaid: this.isPaid);
  }
}
