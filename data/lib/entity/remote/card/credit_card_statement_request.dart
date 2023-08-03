import 'package:json_annotation/json_annotation.dart';

part 'credit_card_statement_request.g.dart';

@JsonSerializable()
class CreditCardStatementRequest {
  // @JsonKey(name: "MonthYear")
  // final String? monthYear;
  @JsonKey(name: "Date")
  final String? date;
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CreditCardStatementRequest(
      {required this.baseData, this.getToken = true, this.date = '', this.cardId = ""});

  factory CreditCardStatementRequest.fromJson(Map<String, dynamic> json) =>
      _$CreditCardStatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardStatementRequestToJson(this);
}
