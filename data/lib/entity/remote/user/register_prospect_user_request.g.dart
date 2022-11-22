// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_prospect_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterProspectUserRequest _$RegisterProspectUserRequestFromJson(Map<String, dynamic> json) {
  return RegisterProspectUserRequest(
    countryName: json['countryName'] as String?,
    languageCode: json['languageCode'] as String?,
    uniqueId: json['uniqueId'] as String?,
    companyId: json['companyId'] as int?,
    email: json['email'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
    mobileCode: json['MobileCode'] as String?,
    password: json['password'] as String?,
    confirmPassword: json['confirmPassword'] as String?,
    userName: json['userName'] as String?,
    fireBaseToken: json['fireBaseToken'] as String?,
    vkeySessionId: json['vkeySessionId'] as String?,
    platform: json['platform'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RegisterProspectUserRequestToJson(RegisterProspectUserRequest instance) =>
    <String, dynamic>{
      'countryName': instance.countryName,
      'languageCode': instance.languageCode,
      'uniqueId': instance.uniqueId,
      'companyId': instance.companyId,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'MobileCode': instance.mobileCode,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'userName': instance.userName,
      'fireBaseToken': instance.fireBaseToken,
      'vkeySessionId': instance.vkeySessionId,
      'platform': instance.platform,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
