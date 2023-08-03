import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/paid_bill_entity.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill_conent.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_prepaid_bill_entity.g.dart';

@JsonSerializable()
class PayPrePaidBillEntity extends BaseLayerDataTransformer<PayPrePaidBillEntity, PaidBillContent> {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "paidBills")
  final List<PaidBillEntity>? paidBills;

  PayPrePaidBillEntity({this.message, this.paidBills});

  factory PayPrePaidBillEntity.fromJson(Map<String, dynamic> json) => _$PayPrePaidBillEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PayPrePaidBillEntityToJson(this);

  @override
  PayPrePaidBillEntity restore(PaidBillContent data) {
    return PayPrePaidBillEntity();
  }

  @override
  PaidBillContent transform() {
    return PaidBillContent(
        message: this.message, paidBill: this.paidBills?.map((e) => e.transform()).toList());
  }
}
