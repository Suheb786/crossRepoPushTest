import 'package:json_annotation/json_annotation.dart';

part 'credit_card_call_status_update_request.g.dart';

@JsonSerializable()
class CreditCardCallStatusUpdateRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "Status")
  final String? status;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CreditCardCallStatusUpdateRequest(
      {required this.baseData, this.getToken: false, this.cardId: "", this.status});

  factory CreditCardCallStatusUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CreditCardCallStatusUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardCallStatusUpdateRequestToJson(this);
}
