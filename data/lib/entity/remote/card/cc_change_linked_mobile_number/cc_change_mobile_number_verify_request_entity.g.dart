// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cc_change_mobile_number_verify_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CcChangeMobileNumberVerifyRequestEntity
    _$CcChangeMobileNumberVerifyRequestEntityFromJson(
            Map<String, dynamic> json) =>
        CcChangeMobileNumberVerifyRequestEntity(
          baseData: json['BaseClass'] as Map<String, dynamic>,
          getToken: json['GetToken'] as bool? ?? true,
          mobileCode: json['MobileCode'] as String?,
          mobileNumber: json['MobileNumber'] as String?,
          tokenizedPan: json['TokenizedPan'] as String?,
        );

Map<String, dynamic> _$CcChangeMobileNumberVerifyRequestEntityToJson(
        CcChangeMobileNumberVerifyRequestEntity instance) =>
    <String, dynamic>{
      'MobileCode': instance.mobileCode,
      'MobileNumber': instance.mobileNumber,
      'TokenizedPan': instance.tokenizedPan,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
