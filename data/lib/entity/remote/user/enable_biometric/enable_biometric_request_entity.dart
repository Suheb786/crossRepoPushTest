import 'package:json_annotation/json_annotation.dart';

part "enable_biometric_request_entity.g.dart";

@JsonSerializable()
class EnableBiometricRequestEntity {
  @JsonKey(name: "Cipher")
  final String? cipher;
  @JsonKey(name: "PublicKey")
  final String? publicKey;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  EnableBiometricRequestEntity({this.cipher, required this.baseData, this.publicKey});

  factory EnableBiometricRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$EnableBiometricRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EnableBiometricRequestEntityToJson(this);
}
