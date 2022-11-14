import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';

part 'pay_prepaid_bill_response.g.dart';

@JsonSerializable()
class PayPrePaidResponse
    extends BaseLayerDataTransformer<PayPrePaidResponse, PayPrePaid> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

 /* @JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final dynamic requestDateTime;

  @JsonKey(name: "logId")
  final dynamic logId;*/

  PayPrePaidResponse({
    this.content,
   /* this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory PayPrePaidResponse.fromJson(Map<String, dynamic> json) =>
      _$PayPrePaidResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayPrePaidResponseToJson(this);

  @override
  PayPrePaid transform() {
    return PayPrePaid(
      content: PayPrePaidBillEntity.fromJson(
        this.content ?? Map(),
      ).transform(),
     /* statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
