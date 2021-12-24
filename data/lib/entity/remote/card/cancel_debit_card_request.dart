import 'package:json_annotation/json_annotation.dart';

part 'cancel_debit_card_request.g.dart';

@JsonSerializable()
class CancelDebitCardRequest {
  @JsonKey(name: "Status")
  final String? reason;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CancelDebitCardRequest(
      {required this.baseData, this.getToken: true, this.reason: ""});

  factory CancelDebitCardRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelDebitCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelDebitCardRequestToJson(this);
}
