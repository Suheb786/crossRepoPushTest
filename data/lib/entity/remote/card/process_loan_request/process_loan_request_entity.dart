import 'package:json_annotation/json_annotation.dart';

part 'process_loan_request_entity.g.dart';

@JsonSerializable()
class ProcessLoanRequestEntity {
  @JsonKey(name: "cardId")
  final String? cardId;
  @JsonKey(name: "loanValueid")
  final num? loanValueId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ProcessLoanRequestEntity({
    required this.baseData,
    this.getToken= true,
    this.cardId= "",
    this.loanValueId= 0,
  });

  factory ProcessLoanRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessLoanRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessLoanRequestEntityToJson(this);
}
