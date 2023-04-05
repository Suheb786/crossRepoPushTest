// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_rtp_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRTPOtpResponseEntity _$ApproveRTPOtpResponseEntityFromJson(
    Map<String, dynamic> json) {
  return ApproveRTPOtpResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ApproveRTPOtpResponseEntityToJson(
        ApproveRTPOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
