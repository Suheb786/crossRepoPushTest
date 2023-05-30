import 'package:json_annotation/json_annotation.dart';

part 'update_favorite_request.g.dart';

@JsonSerializable()
class UpdateFavoriteRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String? beneficiaryDetailId;

  @JsonKey(name: "IsSendMoneyFav")
  final bool? isSendMoneyFav;

  @JsonKey(name: "IsRequestMoneyFav")
  final bool? isRequestMoneyFav;

  @JsonKey(name: "UserId")
  final String? userId;

  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  UpdateFavoriteRequest({
    this.beneficiaryDetailId,
    this.isSendMoneyFav,
    this.isRequestMoneyFav,
    this.userId,
    this.isFromMobile = true,
    this.getToken = true,
    required this.baseData,
  });

  factory UpdateFavoriteRequest.fromJson(Map<String, dynamic> json) => _$UpdateFavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFavoriteRequestToJson(this);
}
