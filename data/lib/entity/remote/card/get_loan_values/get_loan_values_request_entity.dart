import 'package:json_annotation/json_annotation.dart';

part 'get_loan_values_request_entity.g.dart';

@JsonSerializable()
class GetLoanValuesRequestEntity {
  @JsonKey(name: "AccountId")
  final String? accountId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetLoanValuesRequestEntity(
      {required this.baseData, this.getToken: true, this.accountId: "1"});

  factory GetLoanValuesRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetLoanValuesRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoanValuesRequestEntityToJson(this);
}
