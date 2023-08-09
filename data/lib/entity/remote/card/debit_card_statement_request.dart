import 'package:json_annotation/json_annotation.dart';

part 'debit_card_statement_request.g.dart';

@JsonSerializable()
class DebitCardStatementRequest {
  @JsonKey(name: "MonthYear")
  final String? monthYear;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  DebitCardStatementRequest({required this.baseData, this.getToken = true, this.monthYear = ""});

  factory DebitCardStatementRequest.fromJson(Map<String, dynamic> json) =>
      _$DebitCardStatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DebitCardStatementRequestToJson(this);
}
