import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'biller_list_entity.dart';

part 'pay_post_paid_bill_list_entity.g.dart';

@JsonSerializable()
class PayPostPaidBillListEntity
    extends BaseLayerDataTransformer<PayPostPaidBillListEntity, PayPostPaidBillList> {
  @JsonKey(name: "paidBills")
  List<BillerListEntity>? billerListEntity;
  @JsonKey(name: "message")
  String? message;

  PayPostPaidBillListEntity({this.billerListEntity, this.message});

  factory PayPostPaidBillListEntity.fromJson(Map<String, dynamic> json) =>
      _$PayPostPaidBillListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PayPostPaidBillListEntityToJson(this);

  @override
  PayPostPaidBillListEntity restore(PayPostPaidBillList data) {
    return PayPostPaidBillListEntity();
  }

  @override
  PayPostPaidBillList transform() {
    return PayPostPaidBillList(
        message: this.message, billerList: this.billerListEntity?.map((e) => e.transform()).toList());
  }
}
