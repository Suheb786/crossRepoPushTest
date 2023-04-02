// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_result_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayResultOtpEntity _$RequestToPayResultOtpEntityFromJson(Map<String, dynamic> json) {
  return RequestToPayResultOtpEntity(
    mobileCode: json['mobileCode'] as String? ?? '',
    mobileNumber: json['mobileNumber'] as String? ?? '',
  );
}

Map<String, dynamic> _$RequestToPayResultOtpEntityToJson(RequestToPayResultOtpEntity instance) =>
    <String, dynamic>{
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
