import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_prepaid_bill_response.g.dart';

@JsonSerializable()
class PayPrePaidResponse extends BaseLayerDataTransformer<PayPrePaidResponse, PayPrePaid> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PayPrePaidResponse({
    this.response,
  });

  factory PayPrePaidResponse.fromJson(Map<String, dynamic> json) => _$PayPrePaidResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayPrePaidResponseToJson(this);

  @override
  PayPrePaid transform() {
    return PayPrePaid(
      content: PayPrePaidBillEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
    );
  }
}
