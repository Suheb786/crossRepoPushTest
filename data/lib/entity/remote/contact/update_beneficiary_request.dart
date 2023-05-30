import 'package:json_annotation/json_annotation.dart';

part 'update_beneficiary_request.g.dart';

@JsonSerializable()
class UpdateBeneficiaryRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String beneficiaryId;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "IsFromMobile")
  final bool isFromMobile;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  UpdateBeneficiaryRequest({
    required this.beneficiaryId,
    this.nickName,
    this.isFromMobile = true,
    this.getToken = true,
    required this.baseData,
  });

  factory UpdateBeneficiaryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBeneficiaryRequestToJson(this);
}
