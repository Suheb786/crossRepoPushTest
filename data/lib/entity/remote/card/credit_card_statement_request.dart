import 'package:json_annotation/json_annotation.dart';

part 'credit_card_statement_request.g.dart';

@JsonSerializable()
class CreditCardStatementRequest {
  @JsonKey(name: "Days")
  final int? days;
  @JsonKey(name: "AccountId")
  final String? accountId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CreditCardStatementRequest(
      {required this.baseData,
      this.getToken: true,
      this.days: 90,
      this.accountId: "1"});

  factory CreditCardStatementRequest.fromJson(Map<String, dynamic> json) =>
      _$CreditCardStatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardStatementRequestToJson(this);
}
