import 'package:json_annotation/json_annotation.dart';

part 'beneficiary_mark_favorite_request.g.dart';

@JsonSerializable()
class BeneficiaryMarkFavoriteRequest {
  @JsonKey(name: "BeneficiaryDetailId")
  final String beneficiaryDetailId;

  @JsonKey(name: "IsFavorite")
  final bool isFavorite;

  @JsonKey(name: "UserId")
  final String userId;

  @JsonKey(name: "IsFromMobile")
  final bool isFromMobile;

  @JsonKey(name: "BeneType")
  final String beneType;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  BeneficiaryMarkFavoriteRequest({
    required this.beneficiaryDetailId,
    required this.isFavorite,
    required this.userId,
    required this.isFromMobile,
    required this.beneType,
    this.getToken = true,
    required this.baseData,
  });

  factory BeneficiaryMarkFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryMarkFavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryMarkFavoriteRequestToJson(this);
}
