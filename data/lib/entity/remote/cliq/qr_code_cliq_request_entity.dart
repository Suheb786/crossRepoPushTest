import 'package:json_annotation/json_annotation.dart';

part "qr_code_cliq_request_entity.g.dart";

@JsonSerializable()
class QrCodeCliqRequestEntity {
  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "getToken")
  final bool? getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  QrCodeCliqRequestEntity({required this.code, required this.getToken, required this.baseData});

  factory QrCodeCliqRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$QrCodeCliqRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QrCodeCliqRequestEntityToJson(this);
}
