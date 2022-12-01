// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_change_mobile_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyChangeMobileRequestEntity _$VerifyChangeMobileRequestEntityFromJson(
    Map<String, dynamic> json) {
  return VerifyChangeMobileRequestEntity(
    uniqueId: json['UniqueId'] as String,
    otp: json['Otp'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
    mobileNo: json['MobileNo'] as String,
    mobileCode: json['MobileCode'] as String,
  );
}

Map<String, dynamic> _$VerifyChangeMobileRequestEntityToJson(
        VerifyChangeMobileRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'Otp': instance.otp,
      'MobileNo': instance.mobileNo,
      'MobileCode': instance.mobileCode,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
