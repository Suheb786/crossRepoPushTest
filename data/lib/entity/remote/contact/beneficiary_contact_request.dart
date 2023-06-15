import 'package:json_annotation/json_annotation.dart';

part 'beneficiary_contact_request.g.dart';

@JsonSerializable()
class BeneficiaryContactRequest {
  @JsonKey(name: "IsFromMobile")
  final bool isFromMobile;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  BeneficiaryContactRequest({
    required this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory BeneficiaryContactRequest.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryContactRequestToJson(this);
}
