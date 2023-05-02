// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_rtp_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRTPOtpRequestEntity _$ApproveRTPOtpRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ApproveRTPOtpRequestEntity(
      getToken: json['GetToken'] as bool,
      baseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ApproveRTPOtpRequestEntityToJson(
        ApproveRTPOtpRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
