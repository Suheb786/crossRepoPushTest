import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paid_bill_entity.g.dart';

@JsonSerializable()
class PaidBillEntity extends BaseLayerDataTransformer<PaidBillEntity, PaidBill> {
  @JsonKey(name: "billerName")
  final String? billName;

  @JsonKey(name: "billerNameAR")
  final String? billerNameAR;

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
      this.billerNameAR,
      this.totalAmount,
      this.refNo,
      this.date,
      this.statusDescription,
      this.isPaid});

  factory PaidBillEntity.fromJson(Map<String, dynamic> json) => _$PaidBillEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaidBillEntityToJson(this);

  @override
  PaidBillEntity restore(PaidBill data) {
    return PaidBillEntity();
  }

  @override
  PaidBill transform() {
    return PaidBill(
        billName: this.billName != null && this.billName!.isNotEmpty ? this.billName : "",
        billerNameAR: this.billerNameAR != null && this.billerNameAR!.isNotEmpty ? this.billerNameAR : "",
        totalAmount: this.totalAmount != null && this.totalAmount!.isNotEmpty ? this.totalAmount : "0",
        refNo: this.refNo != null && this.refNo!.isNotEmpty ? this.refNo : "",
        date: this.date != null && this.date!.isNotEmpty ? this.date : "",
        statusDescription: this.statusDescription != null && this.statusDescription!.isNotEmpty
            ? this.statusDescription
            : "",
        isPaid: this.isPaid ?? false);
  }
}
