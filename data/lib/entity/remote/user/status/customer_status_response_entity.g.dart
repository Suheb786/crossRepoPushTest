// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerStatusResponseEntity _$CustomerStatusResponseEntityFromJson(Map<String, dynamic> json) {
  return CustomerStatusResponseEntity(
    json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomerStatusResponseEntityToJson(CustomerStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
