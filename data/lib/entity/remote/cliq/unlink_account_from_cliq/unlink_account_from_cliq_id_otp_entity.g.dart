// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlink_account_from_cliq_id_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnlinkAccountFromCliqIdOtp _$UnlinkAccountFromCliqIdOtpFromJson(Map<String, dynamic> json) {
  return UnlinkAccountFromCliqIdOtp(
    mobileCode: json['mobileCode'] as String? ?? '',
    mobileNumber: json['mobileNumber'] as String? ?? '',
  );
}

Map<String, dynamic> _$UnlinkAccountFromCliqIdOtpToJson(UnlinkAccountFromCliqIdOtp instance) =>
    <String, dynamic>{
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
