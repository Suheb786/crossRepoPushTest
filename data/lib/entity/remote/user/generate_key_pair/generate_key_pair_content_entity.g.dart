// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_key_pair_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateKeyPairContentEntity _$GenerateKeyPairContentEntityFromJson(Map<String, dynamic> json) {
  return GenerateKeyPairContentEntity(
    privatePEM: json['privatePEM'] as String?,
    publicPEM: json['publicPEM'] as String?,
  );
}

Map<String, dynamic> _$GenerateKeyPairContentEntityToJson(GenerateKeyPairContentEntity instance) =>
    <String, dynamic>{
      'privatePEM': instance.privatePEM,
      'publicPEM': instance.publicPEM,
    };
