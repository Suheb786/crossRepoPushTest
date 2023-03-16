// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_cliq_id_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCliqOtpEntity _$CreateCliqOtpEntityFromJson(Map<String, dynamic> json) {
  return CreateCliqOtpEntity(
    mobileCode: json['mobileCode'] as String? ?? '',
    mobileNumber: json['mobileNumber'] as String? ?? '',
  );
}

Map<String, dynamic> _$CreateCliqOtpEntityToJson(
        CreateCliqOtpEntity instance) =>
    <String, dynamic>{
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
