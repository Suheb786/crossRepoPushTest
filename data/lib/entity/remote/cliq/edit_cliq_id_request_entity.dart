import 'package:json_annotation/json_annotation.dart';

part "edit_cliq_id_request_entity.g.dart";

@JsonSerializable()
class EditCliqIdRequestEntity {
  @JsonKey(name: "isAlias")
  final bool? isAlias;

  @JsonKey(name: "aliasId")
  final String? aliasId;

  @JsonKey(name: "aliasValue")
  final String? aliasValue;

  @JsonKey(name: "OtpCode")
  final String? OtpCode;
  @JsonKey(name: "getToken")
  final bool? getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  EditCliqIdRequestEntity(
      {required this.isAlias,
      required this.aliasValue,
      required this.aliasId,
      required this.getToken,
      required this.OtpCode,
      required this.baseData});

  factory EditCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$EditCliqIdRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EditCliqIdRequestEntityToJson(this);
}
