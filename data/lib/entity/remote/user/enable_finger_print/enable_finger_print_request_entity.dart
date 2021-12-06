import 'package:json_annotation/json_annotation.dart';

part "enable_finger_print_request_entity.g.dart";

@JsonSerializable()
class EnableFingerPrintRequestEntity {
  @JsonKey(name: "Cipher")
  final String? cipher;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  EnableFingerPrintRequestEntity(
      {this.getToken, required this.baseData, this.cipher});

  factory EnableFingerPrintRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$EnableFingerPrintRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EnableFingerPrintRequestEntityToJson(this);
}
