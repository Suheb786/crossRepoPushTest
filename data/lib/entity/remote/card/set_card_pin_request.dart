import 'package:json_annotation/json_annotation.dart';

part 'set_card_pin_request.g.dart';

@JsonSerializable()
class SetCardPinRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "PinCode")
  final String? pinCode;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SetCardPinRequest(
      {required this.baseData, this.getToken: true, this.pinCode});

  factory SetCardPinRequest.fromJson(Map<String, dynamic> json) =>
      _$SetCardPinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetCardPinRequestToJson(this);
}
