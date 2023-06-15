// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_avatar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveAvatarRequest _$RemoveAvatarRequestFromJson(Map<String, dynamic> json) =>
    RemoveAvatarRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      userId: json['UserId'] as String? ?? '',
      isFromMobile: json['IsFromMobile'] as bool? ?? true,
      beneType: json['BeneType'] as String?,
      nickName: json['Nickname'] as String? ?? '',
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RemoveAvatarRequestToJson(
        RemoveAvatarRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
