import 'package:json_annotation/json_annotation.dart';

part 'update_avatar_request.g.dart';

@JsonSerializable()
class UpdateAvatarRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;

  @JsonKey(name: "UserId")
  final String? userId;

  @JsonKey(name: "BeneImage")
  final String? image;

  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;

  @JsonKey(name: "BeneType")
  final String? beneType;

  @JsonKey(name: "Nickname")
  final String? nickName;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  UpdateAvatarRequest({
    this.beneficiaryDetailId,
    this.userId = '',
    this.image,
    this.beneType,
    this.nickName = '',
    this.isFromMobile = true,
    this.getToken = true,
    required this.baseData,
  });

  factory UpdateAvatarRequest.fromJson(Map<String, dynamic> json) => _$UpdateAvatarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAvatarRequestToJson(this);
}
