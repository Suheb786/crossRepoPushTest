import 'package:json_annotation/json_annotation.dart';

part "delete_cliq_id_otp_request_entity.g.dart";

@JsonSerializable()
class DeleteCliqIdOtpRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  DeleteCliqIdOtpRequestEntity({required this.aliasId, required this.getToken, required this.baseData});

  factory DeleteCliqIdOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$DeleteCliqIdOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCliqIdOtpRequestEntityToJson(this);
}
