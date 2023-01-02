import 'package:json_annotation/json_annotation.dart';

part "verify_qr_request_entity.g.dart";

@JsonSerializable()
class VerifyQRRequestEntity {
  @JsonKey(name: "QrRequestId")
  final String? qrRequestId;
  @JsonKey(name: "Source")
  final String? source;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  VerifyQRRequestEntity({
    this.source,
    this.qrRequestId,
    this.getToken: true,
    this.baseData,
  });

  factory VerifyQRRequestEntity.fromJson(Map<String, dynamic> json) => _$VerifyQRRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyQRRequestEntityToJson(this);
}
