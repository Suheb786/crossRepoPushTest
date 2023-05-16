import 'package:json_annotation/json_annotation.dart';

part 'update_contact_request.g.dart';

@JsonSerializable()
class UpdateContactRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "EmailAddress")
  final String? emailAddress;
  @JsonKey(name: "UserId")
  final String? userId;
  @JsonKey(name: "Identifier")
  final String? identifier;
  @JsonKey(name: "IsFromMobile")
  final String? isFromMobile;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UpdateContactRequest({
    this.beneficiaryDetailId,
    this.nickName,
    this.fullName,
    this.emailAddress,
    this.userId,
    this.identifier,
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory UpdateContactRequest.fromJson(Map<String, dynamic> json) => _$UpdateContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateContactRequestToJson(this);
}
