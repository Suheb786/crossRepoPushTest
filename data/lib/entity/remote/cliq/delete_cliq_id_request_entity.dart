import 'package:json_annotation/json_annotation.dart';

part "delete_cliq_id_request_entity.g.dart";

@JsonSerializable()
class DeleteCliqIdRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;

  @JsonKey(name: "OtpCode")
  final String? otpCode;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  DeleteCliqIdRequestEntity(
      {required this.aliasId, required this.otpCode, required this.getToken, required this.baseData});

  factory DeleteCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$DeleteCliqIdRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCliqIdRequestEntityToJson(this);
}
