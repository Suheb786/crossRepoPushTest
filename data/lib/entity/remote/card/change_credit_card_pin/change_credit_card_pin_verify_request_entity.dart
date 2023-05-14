import 'package:json_annotation/json_annotation.dart';

part 'change_credit_card_pin_verify_request_entity.g.dart';

@JsonSerializable()
class ChangeCreditCardPinVerifyRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "CardCode")
  final String? cardCode;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  ChangeCreditCardPinVerifyRequestEntity({this.getToken= true, this.baseData, this.cardCode= ""});

  factory ChangeCreditCardPinVerifyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangeCreditCardPinVerifyRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeCreditCardPinVerifyRequestEntityToJson(this);
}
