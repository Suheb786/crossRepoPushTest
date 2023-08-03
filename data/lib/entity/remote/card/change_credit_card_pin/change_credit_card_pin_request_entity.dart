import 'package:json_annotation/json_annotation.dart';

part 'change_credit_card_pin_request_entity.g.dart';

@JsonSerializable()
class ChangeCreditCardPinRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "CardCode")
  final String? cardCode;
  @JsonKey(name: "EncryptedPinCode")
  final String? encryptedPinCode;
  @JsonKey(name: "EncryptedCardNumber")
  final String? encryptedCardNumber;
  @JsonKey(name: "otp")
  final String? otp;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  ChangeCreditCardPinRequestEntity(
      {this.getToken = true,
      this.baseData,
      this.cardCode = "",
      this.encryptedCardNumber = "",
      this.encryptedPinCode = '',
      this.otp = ''});

  factory ChangeCreditCardPinRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangeCreditCardPinRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeCreditCardPinRequestEntityToJson(this);
}
