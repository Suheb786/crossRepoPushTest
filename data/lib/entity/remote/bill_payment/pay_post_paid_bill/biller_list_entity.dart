import 'package:domain/model/bill_payments/pay_post_paid_bill/biller_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'biller_list_entity.g.dart';

@JsonSerializable()
class BillerListEntity extends BaseLayerDataTransformer<BillerListEntity, BillerList> {
  @JsonKey(name: "billerName")
  String? billerName;
  @JsonKey(name: "billerNameAR")
  String? billerNameAR;
  @JsonKey(name: "totalAmount")
  String? totalAmount;
  @JsonKey(name: "fee")
  String? fee;
  @JsonKey(name: "refNo")
  String? refNo;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "isPaid")
  bool? isPaid;
  @JsonKey(name: "statusDescription")
  String? statusDescription;

  BillerListEntity(
      {this.billerName,
      this.billerNameAR,
      this.totalAmount,
      this.refNo,
      this.date,
      this.isPaid,
      this.statusDescription});

  factory BillerListEntity.fromJson(Map<String, dynamic> json) => _$BillerListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BillerListEntityToJson(this);

  @override
  BillerList transform() {
    return BillerList(
      billerName: this.billerName ?? "",
      billerNameAR: this.billerNameAR ?? "",
      totalAmount: this.totalAmount ?? "0",
      fee: this.fee ?? "0",
      refNo: this.refNo ?? "",
      date: this.date ?? "",
      isPaid: this.isPaid ?? false,
      statusDescription: this.statusDescription ?? "",
    );
  }
}
