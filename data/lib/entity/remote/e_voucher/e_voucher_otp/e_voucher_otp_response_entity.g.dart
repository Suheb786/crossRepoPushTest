// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_voucher_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EVoucherOtpResponseEntity _$EVoucherOtpResponseEntityFromJson(
        Map<String, dynamic> json) =>
    EVoucherOtpResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EVoucherOtpResponseEntityToJson(
        EVoucherOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
