// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dc_change_mobile_number_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DcChangeMobileNumberRequestEntity _$DcChangeMobileNumberRequestEntityFromJson(Map<String, dynamic> json) {
  return DcChangeMobileNumberRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    mobileCode: json['MobileCode'] as String?,
    otpCode: json['OtpCode'] as String?,
    mobileNumber: json['MobileNumber'] as String?,
    tokenizedPan: json['TokenizedPan'] as String?,
  );
}

Map<String, dynamic> _$DcChangeMobileNumberRequestEntityToJson(DcChangeMobileNumberRequestEntity instance) =>
    <String, dynamic>{
      'MobileCode': instance.mobileCode,
      'MobileNumber': instance.mobileNumber,
      'OtpCode': instance.otpCode,
      'TokenizedPan': instance.tokenizedPan,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
