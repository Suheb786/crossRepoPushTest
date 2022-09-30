import 'package:json_annotation/json_annotation.dart';

part 'unblock_credit_card_pin_request_entity.g.dart';

@JsonSerializable()
class UnblockCreditCardPinRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "CardCode")
  final String? cardCode;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  UnblockCreditCardPinRequestEntity({this.getToken: true, this.baseData, this.cardCode: ""});

  factory UnblockCreditCardPinRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UnblockCreditCardPinRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UnblockCreditCardPinRequestEntityToJson(this);
}
