import 'package:json_annotation/json_annotation.dart';

part 'cancel_credit_card_request.g.dart';

@JsonSerializable()
class CancelCreditCardRequest {
  @JsonKey(name: "Reason")
  final String? reason;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CancelCreditCardRequest(
      {required this.baseData, this.getToken: true, this.reason: ""});

  factory CancelCreditCardRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelCreditCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelCreditCardRequestToJson(this);
}
