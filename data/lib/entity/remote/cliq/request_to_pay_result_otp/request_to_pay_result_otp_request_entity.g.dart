// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_result_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayResultOtpRequestEntity _$RequestToPayResultOtpRequestEntityFromJson(Map<String, dynamic> json) {
  return RequestToPayResultOtpRequestEntity(
    getToken: json['GetToken'] as bool,
    baseClass: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RequestToPayResultOtpRequestEntityToJson(
        RequestToPayResultOtpRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
