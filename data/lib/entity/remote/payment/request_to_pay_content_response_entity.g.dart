// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_content_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayContentResponseEntity _$RequestToPayContentResponseEntityFromJson(
    Map<String, dynamic> json) {
  return RequestToPayContentResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestToPayContentResponseEntityToJson(
        RequestToPayContentResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
