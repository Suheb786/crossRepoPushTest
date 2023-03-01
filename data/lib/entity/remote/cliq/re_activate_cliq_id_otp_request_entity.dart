import 'package:json_annotation/json_annotation.dart';

part "re_activate_cliq_id_otp_request_entity.g.dart";

@JsonSerializable()
class ReActivateCliqIdOtpRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ReActivateCliqIdOtpRequestEntity({required this.aliasId, required this.getToken, required this.baseData});

  factory ReActivateCliqIdOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ReActivateCliqIdOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReActivateCliqIdOtpRequestEntityToJson(this);
}
