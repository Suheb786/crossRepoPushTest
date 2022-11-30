// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dc_change_mobile_number_verify_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DcChangeMobileNumberVerifyRequestEntity
    _$DcChangeMobileNumberVerifyRequestEntityFromJson(
        Map<String, dynamic> json) {
  return DcChangeMobileNumberVerifyRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    mobileCode: json['MobileCode'] as String?,
    mobileNumber: json['MobileNumber'] as String?,
    tokenizedPan: json['TokenizedPan'] as String?,
  );
}

Map<String, dynamic> _$DcChangeMobileNumberVerifyRequestEntityToJson(
        DcChangeMobileNumberVerifyRequestEntity instance) =>
    <String, dynamic>{
      'MobileCode': instance.mobileCode,
      'MobileNumber': instance.mobileNumber,
      'TokenizedPan': instance.tokenizedPan,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
