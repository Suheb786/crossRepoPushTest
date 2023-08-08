import 'package:json_annotation/json_annotation.dart';

part 'remove_avatar_request.g.dart';

@JsonSerializable()
class RemoveAvatarRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;

  @JsonKey(name: "UserId")
  final String? userId;

  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;

  @JsonKey(name: "BeneType")
  final String? beneType;

  @JsonKey(name: "Nickname")
  final String? nickName;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  RemoveAvatarRequest({
    this.beneficiaryDetailId,
    this.userId = '',
    this.isFromMobile = true,
    this.beneType,
    this.nickName = '',
    this.getToken = true,
    required this.baseData,
  });

  factory RemoveAvatarRequest.fromJson(Map<String, dynamic> json) => _$RemoveAvatarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveAvatarRequestToJson(this);
}
