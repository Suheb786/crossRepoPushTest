// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeContentEntity _$PurposeContentEntityFromJson(Map<String, dynamic> json) {
  return PurposeContentEntity(
    transferPurposeResponse: json['transferPurposeResponse'] == null
        ? null
        : TransferPurposeResponseEntity.fromJson(json['transferPurposeResponse'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PurposeContentEntityToJson(PurposeContentEntity instance) => <String, dynamic>{
      'transferPurposeResponse': instance.transferPurposeResponse,
    };
