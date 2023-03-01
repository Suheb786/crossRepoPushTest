import 'package:json_annotation/json_annotation.dart';

part "suspend_cliq_id_otp_request_entity.g.dart";

@JsonSerializable()
class SuspendCliqIdOtpRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SuspendCliqIdOtpRequestEntity({required this.aliasId, required this.getToken, required this.baseData});

  factory SuspendCliqIdOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SuspendCliqIdOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SuspendCliqIdOtpRequestEntityToJson(this);
}
