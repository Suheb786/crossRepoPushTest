import 'package:json_annotation/json_annotation.dart';

part "generate_qr_request_entity.g.dart";

@JsonSerializable()
class GenerateQRRequestEntity {
  @JsonKey(name: "Amount")
  final String? amount;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  GenerateQRRequestEntity({
    this.amount,
    this.getToken: true,
    this.baseData,
  });

  factory GenerateQRRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GenerateQRRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateQRRequestEntityToJson(this);
}
