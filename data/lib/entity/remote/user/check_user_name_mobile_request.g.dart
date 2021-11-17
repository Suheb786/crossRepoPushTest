// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_name_mobile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserNameMobileRequest _$CheckUserNameMobileRequestFromJson(
    Map<String, dynamic> json) {
  return CheckUserNameMobileRequest(
    channelId: json['channelId'] as String?,
    uniqueId: json['uniqueId'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
    countryCode: json['countryCode'] as String?,
    baseData:
        BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckUserNameMobileRequestToJson(
        CheckUserNameMobileRequest instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'uniqueId': instance.uniqueId,
      'mobileNumber': instance.mobileNumber,
      'countryCode': instance.countryCode,
      'baseClass': instance.baseData,
    };
