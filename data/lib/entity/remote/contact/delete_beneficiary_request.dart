import 'package:json_annotation/json_annotation.dart';

part 'delete_beneficiary_request.g.dart';

@JsonSerializable()
class DeleteBeneficiaryRequest {
  @JsonKey(name: "BeneficiaryID")
  final String beneficiaryId;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  DeleteBeneficiaryRequest({
    required this.beneficiaryId,
    this.getToken: true,
    required this.baseData,
  });

  factory DeleteBeneficiaryRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteBeneficiaryRequestToJson(this);
}
