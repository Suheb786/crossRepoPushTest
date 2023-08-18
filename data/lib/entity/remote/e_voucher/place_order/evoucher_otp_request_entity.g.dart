// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evoucher_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EVoucherOtpRequestEntity _$EVoucherOtpRequestEntityFromJson(
        Map<String, dynamic> json) =>
    EVoucherOtpRequestEntity(
      voucherName: json['VoucherName'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$EVoucherOtpRequestEntityToJson(
        EVoucherOtpRequestEntity instance) =>
    <String, dynamic>{
      'VoucherName': instance.voucherName,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
