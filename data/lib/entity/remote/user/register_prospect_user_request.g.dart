// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_prospect_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterProspectUserRequest _$RegisterProspectUserRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterProspectUserRequest(
      countryName: json['CountryName'] as String?,
      languageCode: json['LanguageCode'] as String?,
      uniqueId: json['UniqueId'] as String? ?? "",
      companyId: json['CompanyId'] as int?,
      email: json['Email'] as String?,
      mobileNumber: json['MobileNumber'] as String?,
      mobileCode: json['MobileCode'] as String?,
      password: json['Password'] as String?,
      confirmPassword: json['ConfirmPassword'] as String?,
      userName: json['UserName'] as String?,
      fireBaseToken: json['FireBaseToken'] as String?,
      vkeySessionId: json['VkeySessionId'] as String?,
      platform: json['Platform'] as String?,
      referralCode: json['RefferalPromo'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RegisterProspectUserRequestToJson(
        RegisterProspectUserRequest instance) =>
    <String, dynamic>{
      'CountryName': instance.countryName,
      'LanguageCode': instance.languageCode,
      'UniqueId': instance.uniqueId,
      'CompanyId': instance.companyId,
      'Email': instance.email,
      'MobileNumber': instance.mobileNumber,
      'MobileCode': instance.mobileCode,
      'Password': instance.password,
      'ConfirmPassword': instance.confirmPassword,
      'UserName': instance.userName,
      'FireBaseToken': instance.fireBaseToken,
      'VkeySessionId': instance.vkeySessionId,
      'Platform': instance.platform,
      'RefferalPromo': instance.referralCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
