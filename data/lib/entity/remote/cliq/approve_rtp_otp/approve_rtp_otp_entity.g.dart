// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_rtp_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRTPOtpEntity _$ApproveRTPOtpEntityFromJson(Map<String, dynamic> json) {
  return ApproveRTPOtpEntity(
    mobileCode: json['mobileCode'] as String? ?? '',
    mobileNumber: json['mobileNumber'] as String? ?? '',
  );
}

Map<String, dynamic> _$ApproveRTPOtpEntityToJson(ApproveRTPOtpEntity instance) => <String, dynamic>{
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
