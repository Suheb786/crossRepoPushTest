import 'package:data/entity/remote/payment/payment_activity_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "payment_activity_response_entity.g.dart";

@JsonSerializable()
class PaymentActivityResponseEntity
    implements BaseLayerDataTransformer<PaymentActivityResponseEntity, PaymentActivityResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PaymentActivityResponseEntity({this.response});

  factory PaymentActivityResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentActivityResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentActivityResponseEntityToJson(this);

  @override
  PaymentActivityResponseEntity restore(PaymentActivityResponse response) {
    return PaymentActivityResponseEntity();
  }

  @override
  PaymentActivityResponse transform() {
    return PaymentActivityResponse(
        paymentActivityContent: (this.response!.content as List<dynamic>)
            .map((e) => PaymentActivityContentEntity.fromJson(e).transform())
            .toList());
  }
}
