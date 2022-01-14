import 'package:json_annotation/json_annotation.dart';

part 'process_loan_request_entity.g.dart';

@JsonSerializable()
class ProcessLoanRequestEntity {
  @JsonKey(name: "MinimumSettlement")
  final String? minimumSettlement;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "LoanValueId")
  final num? loanValueId;
  @JsonKey(name: "CreditLimit")
  final num? creditLimit;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ProcessLoanRequestEntity(
      {required this.baseData,
      this.getToken: true,
      this.minimumSettlement: "",
      this.loanValueId: 0,
      this.nickName: "",
      this.creditLimit: 0});

  factory ProcessLoanRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessLoanRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessLoanRequestEntityToJson(this);
}
