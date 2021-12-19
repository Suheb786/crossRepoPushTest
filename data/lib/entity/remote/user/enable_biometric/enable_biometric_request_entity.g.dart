// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enable_biometric_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnableBiometricRequestEntity _$EnableBiometricRequestEntityFromJson(
    Map<String, dynamic> json) {
  return EnableBiometricRequestEntity(
    cipher: json['Cipher'] as String?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
    publicKey: json['PublicKey'] as String?,
  );
}

Map<String, dynamic> _$EnableBiometricRequestEntityToJson(
    EnableBiometricRequestEntity instance) =>
    <String, dynamic>{
      'Cipher': instance.cipher,
      'PublicKey': instance.publicKey,
      'BaseClass': instance.baseData,
    };
