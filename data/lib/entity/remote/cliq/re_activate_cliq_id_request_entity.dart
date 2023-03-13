import 'package:json_annotation/json_annotation.dart';

part "re_activate_cliq_id_request_entity.g.dart";

@JsonSerializable()
class ReActivateCliqIdRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;
  @JsonKey(name: "OtpCode")
  final String? otpCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ReActivateCliqIdRequestEntity(
      {required this.aliasId, required this.otpCode, required this.getToken, required this.baseData});

  factory ReActivateCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ReActivateCliqIdRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReActivateCliqIdRequestEntityToJson(this);
}
