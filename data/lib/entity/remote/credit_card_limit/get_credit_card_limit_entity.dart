import 'package:domain/model/credit_card/credit_card_limit.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_credit_card_limit_entity.g.dart";

@JsonSerializable()
class GetCreditCardLimitEntity
    implements BaseLayerDataTransformer<GetCreditCardLimitEntity, CreditCardLimit> {
  @JsonKey(name: "isATM")
  final bool? isATM;
  @JsonKey(name: "atmCurrentLimit")
  final String? atmCurrentLimit;
  @JsonKey(name: "atmmaxLimit")
  final String? atmMaxLimit;

  @JsonKey(name: "isMarchant")
  final bool? isMerchant;
  @JsonKey(name: "marchantCurrentLimit")
  final String? merchantCurrentLimit;
  @JsonKey(name: "marchantMAXLimit")
  final String? merchantMAXLimit;

  @JsonKey(name: "isOnlinePurchase")
  final bool? isOnlinePurchase;
  @JsonKey(name: "onlinePurchaseCurrentLimit")
  final String? onlinePurchaseCurrentLimit;
  @JsonKey(name: "onlinePurchaseMAXLimit")
  final String? onlinePurchaseMAXLimit;

  @JsonKey(name: "isContactLess")
  final bool? isContactLess;

  GetCreditCardLimitEntity(
      {this.isATM: false,
      this.atmCurrentLimit: "0",
      this.atmMaxLimit: "0",
      this.isMerchant: false,
      this.merchantCurrentLimit: "0",
      this.merchantMAXLimit: "0",
      this.isOnlinePurchase: false,
      this.onlinePurchaseCurrentLimit: "0",
      this.onlinePurchaseMAXLimit: "0",
      this.isContactLess: false});

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
        isOnlinePurchase: this.isOnlinePurchase ?? false,
        atmCurrentLimit: this.atmCurrentLimit ?? "0",
        atmMaxLimit: this.atmMaxLimit ?? '0',
        isATM: this.isATM ?? false,
        isContactLess: this.isContactLess ?? false,
        isMerchant: this.isMerchant ?? false,
        merchantCurrentLimit: this.merchantCurrentLimit ?? "0",
        merchantMaxLimit: this.merchantMAXLimit ?? "0",
        onlinePurchaseCurrentLimit: this.onlinePurchaseCurrentLimit ?? "0",
        onlinePurchaseMaxLimit: this.onlinePurchaseMAXLimit ?? "0");
  }
}
