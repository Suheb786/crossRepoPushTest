import 'package:json_annotation/json_annotation.dart';

part 'add_beneficiary_request.g.dart';

@JsonSerializable()
class AddBeneficiaryRequest {
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "AvatarImg")
  final String? avatarImg;
  @JsonKey(name: "BeneficiaryType")
  final String? beneficiaryType;
  @JsonKey(name: "IsFavourite")
  final bool? isFavourite;
  @JsonKey(name: "UserId")
  final String? userId;
  @JsonKey(name: "Identifier")
  final String? identifier;
  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;
  @JsonKey(name: "DetCustomerType")
  final String? detCustomerType;
  @JsonKey(name: "Alias")
  final String? alias;
  @JsonKey(name: "AddressLine1")
  final String? addressLine1;
  @JsonKey(name: "AddressLine2")
  final String? addressLine2;
  @JsonKey(name: "AddressLine3")
  final String? addressLine3;
  @JsonKey(name: "AddressLine4")
  final String? addressLine4;
  @JsonKey(name: "Limit")
  final int? limit;
  @JsonKey(name: "IFSCCode")
  final String? IFSCCode;
  @JsonKey(name: "RoutingNo")
  final String? routingNo;
  @JsonKey(name: "SortCode")
  final String? sortCode;
  @JsonKey(name: "PurposeType")
  final String? purposeType;
  @JsonKey(name: "Purpose")
  final String? purpose;
  @JsonKey(name: "PurposeDetails")
  final String? purposeDetails;
  @JsonKey(name: "PurposeParent")
  final String? purposeParent;
  @JsonKey(name: "PurposeParentDetails")
  final String? purposeParentDetails;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  AddBeneficiaryRequest({
    this.nickName,
    this.fullName,
    this.avatarImg,
    this.beneficiaryType,
    this.isFavourite,
    this.userId,
    this.identifier,
    this.isFromMobile,
    this.detCustomerType,
    this.alias,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.addressLine4,
    this.limit,
    this.IFSCCode,
    this.routingNo,
    this.sortCode,
    this.purposeType,
    this.purpose,
    this.purposeDetails,
    this.purposeParent,
    this.purposeParentDetails,
    this.getToken = true,
    required this.baseData,
  });

  factory AddBeneficiaryRequest.fromJson(Map<String, dynamic> json) => _$AddBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryRequestToJson(this);
}
