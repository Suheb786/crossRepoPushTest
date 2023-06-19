import 'package:json_annotation/json_annotation.dart';

part 'beneficiary_fav_request.g.dart';

@JsonSerializable()
class BeneficiaryFavoriteRequest {
  @JsonKey(name: "IsFromMobile")
  final bool isFromMobile;

  @JsonKey(name: "BeneType")
  final String beneType;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  BeneficiaryFavoriteRequest({
    required this.isFromMobile,
    required this.beneType,
    this.getToken = true,
    required this.baseData,
  });

  factory BeneficiaryFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryFavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryFavoriteRequestToJson(this);
}
