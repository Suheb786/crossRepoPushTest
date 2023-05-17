import 'package:json_annotation/json_annotation.dart';

part 'delete_contact_request.g.dart';

@JsonSerializable()
class DeleteContactRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "EmailAddress")
  final String? emailAddress;
  @JsonKey(name: "AvatarImg")
  final String? avatarImg;
  @JsonKey(name: "IsFav")
  final bool? isFav;
  @JsonKey(name: "UserId")
  final String? userId;
  @JsonKey(name: "IsFromMobile")
  final String? isFromMobile;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  DeleteContactRequest({
    this.beneficiaryDetailId,
    this.nickName,
    this.fullName,
    this.emailAddress,
    this.avatarImg,
    this.isFav,
    this.userId,
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory DeleteContactRequest.fromJson(Map<String, dynamic> json) => _$DeleteContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteContactRequestToJson(this);
}
