// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_mobile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeMobileRequest _$ChangeMobileRequestFromJson(Map<String, dynamic> json) {
  return ChangeMobileRequest(
    mobile: json['MobileNo'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
    mobileCode: json['MobileCode'] as String,
  );
}

Map<String, dynamic> _$ChangeMobileRequestToJson(
        ChangeMobileRequest instance) =>
    <String, dynamic>{
      'MobileNo': instance.mobile,
      'MobileCode': instance.mobileCode,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
