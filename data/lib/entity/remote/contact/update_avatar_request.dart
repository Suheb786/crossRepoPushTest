import 'package:json_annotation/json_annotation.dart';

part 'update_avatar_request.g.dart';

@JsonSerializable()
class UpdateAvatarRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;
  @JsonKey(name: "AvatarImg")
  final String? avatarImg;
  @JsonKey(name: "UserId")
  final String? userId;
  @JsonKey(name: "IsFromMobile")
  final String? isFromMobile;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UpdateAvatarRequest({
    this.beneficiaryDetailId,
    this.avatarImg,
    this.userId,
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory UpdateAvatarRequest.fromJson(Map<String, dynamic> json) => _$UpdateAvatarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAvatarRequestToJson(this);
}
