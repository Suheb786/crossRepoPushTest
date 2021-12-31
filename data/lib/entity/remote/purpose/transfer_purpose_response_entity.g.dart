// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_purpose_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferPurposeResponseEntity _$TransferPurposeResponseEntityFromJson(
    Map<String, dynamic> json) {
  return TransferPurposeResponseEntity(
    purposes: (json['purposes'] as List<dynamic>?)
        ?.map((e) => PurposeEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TransferPurposeResponseEntityToJson(
        TransferPurposeResponseEntity instance) =>
    <String, dynamic>{
      'purposes': instance.purposes,
    };
