// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_kyc_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckKycStatusResponseEntity _$CheckKycStatusResponseEntityFromJson(
    Map<String, dynamic> json) {
  return CheckKycStatusResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckKycStatusResponseEntityToJson(
    CheckKycStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
