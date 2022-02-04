import 'package:json_annotation/json_annotation.dart';

part "pay_back_credit_card_request_entity.g.dart";

@JsonSerializable()
class PayBackCreditCardRequestEntity {
  @JsonKey(name: "SecureCode")
  final String? secureCode;
  @JsonKey(name: "PayBackAmount")
  final String? payBackAmount;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  PayBackCreditCardRequestEntity({
    this.payBackAmount: "",
    this.secureCode: "",
    this.getToken: true,
    this.baseData,
  });

  factory PayBackCreditCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PayBackCreditCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PayBackCreditCardRequestEntityToJson(this);
}
