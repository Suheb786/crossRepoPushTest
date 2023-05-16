import 'package:json_annotation/json_annotation.dart';

part 'contact_detail_request.g.dart';

@JsonSerializable()
class ContactDetailRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;

  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ContactDetailRequest({
    this.beneficiaryDetailId,
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory ContactDetailRequest.fromJson(Map<String, dynamic> json) => _$ContactDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailRequestToJson(this);
}
