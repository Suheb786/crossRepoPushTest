import 'package:json_annotation/json_annotation.dart';

part 'change_debit_card_pin_request.g.dart';

@JsonSerializable()
class ChangeDebitCardPinRequest {
  // @JsonKey(name: "PinCode")
  // final String? pinCode;
  // @JsonKey(name: "otp")
  // final String? otp;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ChangeDebitCardPinRequest(
      {required this.baseData,
      this.getToken: true,
      //required this.pinCode,
      this.tokenizedPan,
      //this.otp
      });

  factory ChangeDebitCardPinRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeDebitCardPinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeDebitCardPinRequestToJson(this);
}
