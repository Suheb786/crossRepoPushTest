import 'package:domain/model/credit_card/credit_card_limit.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_credit_card_limit_entity.g.dart";

@JsonSerializable()
class GetCreditCardLimitEntity
    implements
        BaseLayerDataTransformer<GetCreditCardLimitEntity, CreditCardLimit> {
  ///online purchase
  @JsonKey(name: "monthlyinternettranmin")
  String? internetLimitMin;
  @JsonKey(name: "monthlyinternettranmax")
  String? internetLimitMax;
  @JsonKey(name: "dailycashnbtranlimit")
  String? internetCurrentLimit;

  GetCreditCardLimitEntity(
      {this.internetLimitMin: "0",
      this.internetLimitMax: "0",
      this.internetCurrentLimit: "0"});

  factory GetCreditCardLimitEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCreditCardLimitEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditCardLimitEntityToJson(this);

  @override
  GetCreditCardLimitEntity restore(CreditCardLimit response) {
    return GetCreditCardLimitEntity();
  }

  @override
  CreditCardLimit transform() {
    return CreditCardLimit(
        currentLimit: this.internetCurrentLimit ?? '0',
        maxLimit: this.internetLimitMax ?? '0',
        minLimit: this.internetLimitMin ?? '0');
  }
}
