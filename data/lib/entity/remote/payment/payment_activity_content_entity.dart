import 'package:data/entity/remote/payment/payment_activity_data_entity.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "payment_activity_content_entity.g.dart";

@JsonSerializable()
class PaymentActivityContentEntity
    implements
        BaseLayerDataTransformer<PaymentActivityContentEntity,
            PaymentActivityContent> {
  @JsonKey(name: "rtpDate")
  DateTime? rtpDate;
  @JsonKey(name: "data")
  List<PaymentActivityDataEntity>? data;

  PaymentActivityContentEntity({this.rtpDate, this.data});

  factory PaymentActivityContentEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentActivityContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentActivityContentEntityToJson(this);

  @override
  PaymentActivityContentEntity restore(PaymentActivityContent response) {
    return PaymentActivityContentEntity();
  }

  @override
  PaymentActivityContent transform() {
    return PaymentActivityContent(
        rtpDate: this.rtpDate,
        data: this.data!.map((e) => e.transform()).toList());
  }
}
