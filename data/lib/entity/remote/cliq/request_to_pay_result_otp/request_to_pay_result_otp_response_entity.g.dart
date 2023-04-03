// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_result_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayResultOtpResponseEntity
    _$RequestToPayResultOtpResponseEntityFromJson(Map<String, dynamic> json) {
  return RequestToPayResultOtpResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestToPayResultOtpResponseEntityToJson(
        RequestToPayResultOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
