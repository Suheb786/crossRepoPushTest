import 'package:json_annotation/json_annotation.dart';

part "suspend_cliq_id_request_entity.g.dart";

@JsonSerializable()
class SuspendCliqIdRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;

  @JsonKey(name: "OtpCode")
  final String? otpCode;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SuspendCliqIdRequestEntity(
      {required this.aliasId, required this.otpCode, required this.getToken, required this.baseData});

  factory SuspendCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SuspendCliqIdRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SuspendCliqIdRequestEntityToJson(this);
}
