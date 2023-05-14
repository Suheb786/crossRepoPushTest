import 'package:json_annotation/json_annotation.dart';

part 'update_beneficiary_request.g.dart';

@JsonSerializable()
class UpdateBeneficiaryRequest {
  @JsonKey(name: "BeneficiaryID")
  final String beneficiaryId;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "Purpose")
  final String? purpose;
  @JsonKey(name: "PurposeDetails")
  final String? purposeDetails;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UpdateBeneficiaryRequest({
    required this.beneficiaryId,
    this.nickName,
    this.purpose,
    this.purposeDetails,
    this.getToken= true,
    required this.baseData,
  });

  factory UpdateBeneficiaryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBeneficiaryRequestToJson(this);
}
