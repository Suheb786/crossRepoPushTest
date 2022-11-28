// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_success_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferSuccessResponseEntity _$TransferSuccessResponseEntityFromJson(Map<String, dynamic> json) {
  return TransferSuccessResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferSuccessResponseEntityToJson(TransferSuccessResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
