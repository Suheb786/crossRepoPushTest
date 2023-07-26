import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_list_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_post_paid_bill_response.g.dart';

@JsonSerializable()
class PayPostPaidBillResponse extends BaseLayerDataTransformer<PayPostPaidBillResponse, PayPostPaidBill> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PayPostPaidBillResponse({
    this.response,
  });

  factory PayPostPaidBillResponse.fromJson(Map<String, dynamic> json) =>
      _$PayPostPaidBillResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayPostPaidBillResponseToJson(this);

  @override
  PayPostPaidBill transform() {
    return PayPostPaidBill(
      content: PayPostPaidBillListEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
    );
  }
}
